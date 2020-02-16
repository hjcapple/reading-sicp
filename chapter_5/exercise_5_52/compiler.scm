#lang sicp

;; P430 - [练习 5.52]

(#%require "../ch5-syntax.scm")			;section 4.1.2 syntax procedures
(#%provide compile statements)


(define (let? exp) (tagged-list? exp 'let))

(define (let->combination exp)
  (define (let-body exp) (cddr exp))
  (define (let-vars exp) (map car (cadr exp)))
  (define (let-exps exp) (map cadr (cadr exp)))
  
  (cons (make-lambda (let-vars exp) 
                     (let-body exp)) 
        (let-exps exp)))

;;;SECTION 5.5.1

(define (compile exp target linkage)
  (cond ((self-evaluating? exp)
         (compile-self-evaluating exp target linkage))
        ((quoted? exp) (compile-quoted exp target linkage))
        ((variable? exp)
         (compile-variable exp target linkage))
        ((assignment? exp)
         (compile-assignment exp target linkage))
        ((definition? exp)
         (compile-definition exp target linkage))
        ((if? exp) (compile-if exp target linkage))
        ((lambda? exp) (compile-lambda exp target linkage))
        ((begin? exp)
         (compile-sequence (begin-actions exp)
                           target
                           linkage))
        ((cond? exp) (compile (cond->if exp) target linkage))
        ((let? exp) (compile (let->combination exp) target linkage))
        ((application? exp)
         (compile-application exp target linkage))
        (else
         (error "Unknown expression type -- COMPILE" exp))))


(define (make-instruction-sequence needs modifies statements)
  (list needs modifies statements))

(define (empty-instruction-sequence)
  (make-instruction-sequence '() '() '()))


;;;SECTION 5.5.2

;;;linkage code

(define (compile-linkage linkage)
  (cond ((eq? linkage 'return)
         (make-instruction-sequence '(continue_) '()
          '(
            (goto *label_get(continue_) ";")
            )))
        ((eq? linkage 'next)
         (empty-instruction-sequence))
        (else
         (make-instruction-sequence '() '()
          `(
            (goto " " ,linkage ";")
            )))))

(define (end-with-linkage linkage instruction-sequence)
  (preserving '(continue_)
   instruction-sequence
   (compile-linkage linkage)))


;;;simple expressions

(define (assign-exp target exp)
  (list (cond ((number? exp) `(number (,target "," ,exp) ";"))
              ((boolean? exp) `(boolean (,target "," ,(if exp 1 0)) ";"))
              ((string? exp) `(str (,target "," ,(c-string exp)) ";"))
              ((symbol? exp) `(symbol (,target "," ,(c-symbol exp)) ";"))
              ((null? exp) `(null (,target) ";"))
              (else (error "Unknown type" exp)))))
      

(define (compile-self-evaluating exp target linkage)
  (end-with-linkage linkage
   (make-instruction-sequence '() (list target)
     (assign-exp target exp))))                              

(define (compile-quoted exp target linkage)
  (end-with-linkage linkage
   (make-instruction-sequence '() (list target)
      (assign-exp target (text-of-quotation exp)))))                     

(define (compile-variable exp target linkage)
  (end-with-linkage linkage
   (make-instruction-sequence '(env) (list target)
    `(
      (lookup_variable_value (,target "," symbol (tmp "," ,(c-symbol exp)) "," env) ";")
    ))))

(define (compile-assignment exp target linkage)
  (let ((var (assignment-variable exp))
        (get-value-code
         (compile (assignment-value exp) 'val 'next)))
    (end-with-linkage linkage
     (preserving '(env)
      get-value-code
      (make-instruction-sequence '(env val) (list target)
       `(
         (set_variable_value (symbol (tmp "," ,(c-symbol var)) "," val "," env) ";")
         (symbol (,target "," ,(c-symbol 'ok)) ";")
         ))))))

(define (compile-definition exp target linkage)
  (let ((var (definition-variable exp))
        (get-value-code
         (compile (definition-value exp) 'val 'next)))
    (end-with-linkage linkage
     (preserving '(env)
      get-value-code
      (make-instruction-sequence '(env val) (list target)
       `(
         (define_variable (symbol (tmp ", " ,(c-symbol var)) "," val "," env) ";")
         (symbol (,target "," ,(c-symbol 'ok)) ";")
         ))))))


;;;conditional expressions

;;;labels (from footnote)
(define label-counter 0)

(define (new-label-number)
  (set! label-counter (+ 1 label-counter))
  label-counter)

(define (make-label name)
  (string->symbol
    (string-append (symbol->string name)
                   (number->string (new-label-number)))))

(define (c-label label)
  (string->symbol
    (string-append (symbol->string label) ":")))

;; end of footnote

(define (compile-if exp target linkage)
  (let ((t-branch (make-label 'true_branch))
        (f-branch (make-label 'false_branch))                    
        (after-if (make-label 'after_if)))
    (let ((consequent-linkage
           (if (eq? linkage 'next) after-if linkage)))
      (let ((p-code (compile (if-predicate exp) 'val 'next))
            (c-code
             (compile
              (if-consequent exp) target consequent-linkage))
            (a-code
             (compile (if-alternative exp) target linkage)))
        (preserving '(env continue_)
         p-code
         (append-instruction-sequences
          (make-instruction-sequence '(val) '()
           `(
              ("if " (is_false (val)) " {")
              (goto " " ,f-branch ";")
              ("};")
           ))
          (parallel-instruction-sequences
           (append-instruction-sequences (c-label t-branch) c-code)
           (append-instruction-sequences (c-label f-branch) a-code))
          (c-label after-if)))))))

;;; sequences

(define (compile-sequence seq target linkage)
  (if (last-exp? seq)
      (compile (first-exp seq) target linkage)
      (preserving '(env continue_)
       (compile (first-exp seq) target 'next)
       (compile-sequence (rest-exps seq) target linkage))))

;;;lambda expressions

(define (compile-lambda exp target linkage)
  (let ((proc-entry (make-label 'entry))
        (after-lambda (make-label 'after_lambda)))
    (let ((lambda-linkage
           (if (eq? linkage 'next) after-lambda linkage)))
      (append-instruction-sequences
       (tack-on-instruction-sequence
        (end-with-linkage lambda-linkage
         (make-instruction-sequence '(env) (list target)
          `(
            (make_compiled_procedure (,target "," label (tmp "," &&,proc-entry) "," env) ";")
            )))
        (compile-lambda-body exp proc-entry))
        (c-label after-lambda)))))

(define (c-symbol s)
  (string-append "\"" (symbol->string s) "\""))

(define (c-string s)
  (string-append "\"" s "\""))

(define (symbol-list vars)
  (define (loop rest result)
    (if (null? rest)
        (append result (list ")"))
        (loop (cdr rest) 
              (append result (list "," (c-symbol (car rest)))))))
  (loop vars (list "symbol_list(tmp , " (length vars))))
  
(define (compile-lambda-body exp proc-entry)
  (let ((formals (lambda-parameters exp)))
    (append-instruction-sequences
     (make-instruction-sequence '(env proc argl) '(env)
      `(
        ,(c-label proc-entry)
        (compiled_procedure_env (env "," proc) ";")
        (extend_environment (env, "," ,(symbol-list formals) "," argl "," env) ";")
        ))
     (compile-sequence (lambda-body exp) 'val 'return))))


;;;SECTION 5.5.3

;;;combinations

(define (compile-application exp target linkage)
  (let ((proc-code (compile (operator exp) 'proc 'next))
        (operand-codes
         (map (lambda (operand) (compile operand 'val 'next))
              (operands exp))))
    (preserving '(env continue_)
     proc-code
     (preserving '(proc continue_)
      (construct-arglist operand-codes)
      (compile-procedure-call target linkage)))))

(define (construct-arglist operand-codes)
  (let ((operand-codes (reverse operand-codes)))
    (if (null? operand-codes)
        (make-instruction-sequence '() '(argl)
         '(
            (null (argl) ";")
           ))
        (let ((code-to-get-last-arg
               (append-instruction-sequences
                (car operand-codes)
                (make-instruction-sequence '(val) '(argl)
                 '(
                   (null (argl) ";")
                   (cons (argl "," val ", " argl) ";")
                   )))))
          (if (null? (cdr operand-codes))
              code-to-get-last-arg
              (preserving '(env)
               code-to-get-last-arg
               (code-to-get-rest-args
                (cdr operand-codes))))))))

(define (code-to-get-rest-args operand-codes)
  (let ((code-for-next-arg
         (preserving '(argl)
          (car operand-codes)
          (make-instruction-sequence '(val argl) '(argl)
           '(
             (cons (argl "," val "," argl) ";")
             )))))
    (if (null? (cdr operand-codes))
        code-for-next-arg
        (preserving '(env)
         code-for-next-arg
         (code-to-get-rest-args (cdr operand-codes))))))

;;;applying procedures

(define (compile-procedure-call target linkage)
  (let ((primitive-branch (make-label 'primitive_branch))
        (compiled-branch (make-label 'compiled_branch))
        (after-call (make-label 'after_call)))
    (let ((compiled-linkage
           (if (eq? linkage 'next) after-call linkage)))
      (append-instruction-sequences
       (make-instruction-sequence '(proc) '()
        `(
          ("if " (is_primitive_procedure ( proc)) " {")
          (goto " " ,primitive-branch ";")
          ("};")
          ))
       (parallel-instruction-sequences
        (append-instruction-sequences
         (c-label compiled-branch)
         (compile-proc-appl target compiled-linkage))
        (append-instruction-sequences
         (c-label primitive-branch)
         (end-with-linkage linkage
          (make-instruction-sequence '(proc argl)
                                     (list target)
           `(
              (apply_primitive_procedure (,target "," proc "," argl) ";")
           )))))
       (c-label after-call)))))

;;;applying compiled procedures

(define (compile-proc-appl target linkage)
  (cond ((and (eq? target 'val) (not (eq? linkage 'return)))
         (make-instruction-sequence '(proc) all-regs
           `(
             (label (continue_ "," &&,linkage) ";")
             (compiled_procedure_entry (val "," proc) ";")
             (goto *label_get(val) ";")
             )))
        ((and (not (eq? target 'val))
              (not (eq? linkage 'return)))
         (let ((proc-return (make-label 'proc-return)))
           (make-instruction-sequence '(proc) all-regs
            `(
              (label (continue_ "," &&,proc-return) ";")
              (compiled_procedure_entry (val "," proc) ";")
              (goto *label_get(val) ";")
              (,proc-return ":")
              (assign (,target "," val) ";")
              (goto *label_get(linkage) ";")
              ))))
        ((and (eq? target 'val) (eq? linkage 'return))
         (make-instruction-sequence '(proc continue_) all-regs
          '(
            (compiled_procedure_entry (val "," proc) ";")
            (goto *label_get(val) ";")
            )))
        ((and (not (eq? target 'val)) (eq? linkage 'return))
         (error "return linkage, target not val -- COMPILE"
                target))))

;; footnote
(define all-regs '(env proc val argl continue_))


;;;SECTION 5.5.4

(define (registers-needed s)
  (if (symbol? s) '() (car s)))

(define (registers-modified s)
  (if (symbol? s) '() (cadr s)))

(define (statements s)
  (if (symbol? s) (list s) (caddr s)))

(define (needs-register? seq reg)
  (memq reg (registers-needed seq)))

(define (modifies-register? seq reg)
  (memq reg (registers-modified seq)))


(define (append-instruction-sequences . seqs)
  (define (append-2-sequences seq1 seq2)
    (make-instruction-sequence
     (list-union (registers-needed seq1)
                 (list-difference (registers-needed seq2)
                                  (registers-modified seq1)))
     (list-union (registers-modified seq1)
                 (registers-modified seq2))
     (append (statements seq1) (statements seq2))))
  (define (append-seq-list seqs)
    (if (null? seqs)
        (empty-instruction-sequence)
        (append-2-sequences (car seqs)
                            (append-seq-list (cdr seqs)))))
  (append-seq-list seqs))

(define (list-union s1 s2)
  (cond ((null? s1) s2)
        ((memq (car s1) s2) (list-union (cdr s1) s2))
        (else (cons (car s1) (list-union (cdr s1) s2)))))

(define (list-difference s1 s2)
  (cond ((null? s1) '())
        ((memq (car s1) s2) (list-difference (cdr s1) s2))
        (else (cons (car s1)
                    (list-difference (cdr s1) s2)))))

(define (preserving regs seq1 seq2)
  (if (null? regs)
      (append-instruction-sequences seq1 seq2)
      (let ((first-reg (car regs)))
        (if (and (needs-register? seq2 first-reg)
                 (modifies-register? seq1 first-reg))
            (preserving (cdr regs)
             (make-instruction-sequence
              (list-union (list first-reg)
                          (registers-needed seq1))
              (list-difference (registers-modified seq1)
                               (list first-reg))
              (append `(
                        (save (,first-reg) ";")
                        )
                      (statements seq1)
                      `(
                        (restore (,first-reg) ";")
                        )))
             seq2)
            (preserving (cdr regs) seq1 seq2)))))

(define (tack-on-instruction-sequence seq body-seq)
  (make-instruction-sequence
   (registers-needed seq)
   (registers-modified seq)
   (append (statements seq) (statements body-seq))))

(define (parallel-instruction-sequences seq1 seq2)
  (make-instruction-sequence
   (list-union (registers-needed seq1)
               (registers-needed seq2))
   (list-union (registers-modified seq1)
               (registers-modified seq2))
   (append (statements seq1) (statements seq2))))

;'(COMPILER LOADED)
