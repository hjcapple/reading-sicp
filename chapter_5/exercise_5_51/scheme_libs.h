// clang-format off
// 这个文件直接被 C 语言 #include, 载入到环境中，用于实现基础的 Scheme 函数

#define StdLib(x) #x

static const char *scheme_libs =

StdLib(
       // 用于实现 cond 语法
       (define (meta-syntax-cond->if exp)
         (define (make-if predicate consequent alternative)
           (list (quote if) predicate consequent alternative))
         (define (sequence->exp seq)
           (if (null? seq)
               seq
               (if (null? (cdr seq))
                   (car seq)
                   (make-begin seq))))
         (define (make-begin seq) (cons (quote begin) seq))
         (define (cond-clauses exp) (cdr exp))
         (define (cond-else-clause? clause) (eq? (cond-predicate clause) (quote else)))
         (define (cond-predicate clause) (car clause))
         (define (cond-actions clause) (cdr clause))
         (define (expand-clauses clauses)
           (if (null? clauses)
               (quote false)
               (let ((first (car clauses))
                     (rest (cdr clauses)))
                 (if (cond-else-clause? first)
                     (if (null? rest)
                         (sequence->exp (cond-actions first))
                         (error "ELSE clause isn't last -- COND->IF"
                                clauses))
                     (make-if (cond-predicate first)
                              (sequence->exp (cond-actions first))
                              (expand-clauses rest))))))
         
         (expand-clauses (cond-clauses exp)))
       
       // 用于实现 let 语法
       (define (meta-syntax-let->combination exp)
         (define (let-body exp) (cddr exp))
         (define (let-vars exp) (map car (cadr exp)))
         (define (let-exps exp) (map cadr (cadr exp)))
         (define (make-lambda parameters body)
           (cons (quote lambda) (cons parameters body)))
         (cons (make-lambda (let-vars exp) 
                            (let-body exp)) 
               (let-exps exp)))
       
       // 用于实现 let*
       (define (meta-syntax-let*->nested-lets exp)
         (define (make-let vars body)
           (cons (quote let) (cons vars body)))
         
         (define (expand-let*-vars vars body)
           (cond ((null? vars) (make-let vars body))
                 ((null? (cdr vars)) (make-let vars body))
                 (else (make-let (list (car vars))
                                 (list (expand-let*-vars (cdr vars) body))))))
         
         (define (let*-body exp) (cddr exp))
         (define (let*-vars exp) (cadr exp))
         
         (expand-let*-vars (let*-vars exp) (let*-body exp)))
       
       (define (abs x)
         (cond ((< x 0) (- x))
               (else x)))
       
       (define (displayln x)
         (display x)
         (newline))
       
       (define (length items)
         (if (null? items)
             0
             (+ 1 (length (cdr items)))))
       
       (define (reverse items)
         (define (iter items result)
           (if (null? items)
               result
               (iter (cdr items) (cons (car items) result))))
         (iter items null))
       
       (define (map op sequence)
         (if (null? sequence)
             (quote ())
             (cons (op (car sequence)) (map op (cdr sequence)))))

       (define (filter predicate sequence)
          (if (null? sequence)
              null
              (if (predicate (car sequence))
                  (cons (car sequence) (filter predicate (cdr sequence)))
                  (filter predicate (cdr sequence)))))
       
       (define (memq item x)
         (cond ((null? x) #f)
               ((eq? item (car x)) x)
               (else (memq item (cdr x)))))
       
       (define (cadr lst) (car (cdr lst)))
       (define (cddr lst) (cdr (cdr lst)))
       (define (caadr lst) (car (car (cdr lst))))
       (define (caddr lst) (car (cdr (cdr lst))))
       (define (cdadr lst) (cdr (car (cdr lst))))
       (define (cdddr lst) (cdr (cdr (cdr lst))))
       (define (cadddr lst) (car (cdr (cdr (cdr lst)))))
       (define (not x) (if x false true))
       
       );



