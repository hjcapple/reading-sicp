#lang racket

;; P340 - [练习 4.78, 非确定性写法实现查询]

(define user-initial-environment (make-base-namespace))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (query-driver-loop)
  (define (internal-loop try-again)
    (prompt-for-input ";;; Query input:")
    (let* ((input (read))
           (q (query-syntax-process input)))
      (cond ((eq? q 'try-again) (try-again))
            ((assertion-to-be-added? q)
             (add-rule-or-assertion! (add-assertion-body q))
             (newline)
             (display "Assertion added to data base.")
             (query-driver-loop))
            (else
              (newline)
              (display ";;; Starting a new query ")
              (qeval q 
                     '()
                     (lambda (frame next-alternative)
                       (display-line ";;; Query results:")
                       (display-line (instantiate q
                                                  frame
                                                  (lambda (v f)
                                                    (contract-question-mark v))))
                       (internal-loop next-alternative))
                     (lambda ()
                       (display-line ";;; There are no more values of")
                       (display-line input)
                       (query-driver-loop)))))))
  (internal-loop (lambda ()
                   (newline)
                   (display ";;; There is no current query")
                   (query-driver-loop))))


(define (instantiate exp frame unbound-var-handler)
  (define (copy exp)
    (cond ((var? exp)
           (let ((binding (binding-in-frame exp frame)))
             (if binding
                 (copy (binding-value binding))
                 (unbound-var-handler exp frame))))
          ((pair? exp)
           (cons (copy (car exp)) (copy (cdr exp))))
          (else exp)))
  (copy exp))

(define (qeval query frame succeed fail)
  ((analyze query frame) succeed fail))

(define (analyze exp frame)
  (cond ((tagged-list? exp 'and) (conjoin (contents exp) frame))
        ((tagged-list? exp 'lisp-value) (lisp-value (contents exp) frame))
        ((tagged-list? exp 'not) (negate (contents exp) frame))
        ((tagged-list? exp 'or) (disjoin (contents exp) frame))
        ((tagged-list? exp 'always-true) (always-true (contents exp) frame))
        (else (simple-query exp frame))))

;;;Simple queries
(define (simple-query query-pattern frame)
  (lambda (succeed fail)
    ((find-assertions query-pattern frame)
     succeed
     (lambda ()
       ((apply-rules query-pattern frame) succeed fail)))))

;;;Compound queries
(define (conjoin conjuncts frame)
  (lambda (succeed fail)
    (let ((first (analyze (car conjuncts) frame)))
      (if (null? (cdr conjuncts))
          (first succeed fail)
          (first (lambda (frame2 fail2)
                   ((conjoin (cdr conjuncts) frame2)
                    succeed
                    fail2))
                 fail)))))

(define (disjoin disjuncts frame)
  (lambda (succeed fail)
    (define (try-next choices)
      (if (null? choices)
          (fail)
          ((analyze (car choices) frame)
           succeed
           (lambda ()
             (try-next (cdr choices))))))
    (try-next disjuncts)))

(define (negate operands frame)
  (lambda (succeed fail)
    ((analyze (negated-query operands) frame)
     (lambda (frame2 fail2)
       (fail))
     (lambda ()
       (succeed frame fail)))))

(define (lisp-value call frame)
  (lambda (succeed fail)
    (if (execute
          (instantiate
            call
            frame
            (lambda (v f)
              (error "Unknown pat var -- LISP-VALUE" v))))
        (succeed frame fail)
        (fail))))

(define (execute exp)
  (apply (eval (predicate exp) user-initial-environment)
         (args exp)))

(define (always-true ignore frame)
  (lambda (succeed fail)
    (succeed frame fail)))

;;;SECTION 4.4.4.3
;;;Finding Assertions by Pattern Matching

(define (find-assertions pattern frame)
  (let ((records (fetch-assertions pattern frame)))
    (lambda (succeed fail)
      (define (try-next choices)
        (if (null? choices)
            (fail)
            ((check-an-assertion (car choices) pattern frame)
             succeed
             (lambda ()
               (try-next (cdr choices))))))
      (try-next records))))

(define (check-an-assertion assertion query-pat query-frame)
  (lambda (succeed fail)
    (let ((match-result (pattern-match query-pat assertion query-frame)))
      (if (eq? match-result 'failed)
          (fail)
          (succeed match-result fail)))))

(define (pattern-match pat dat frame)
  (cond ((eq? frame 'failed) 'failed)
        ((equal? pat dat) frame)
        ((var? pat) (extend-if-consistent pat dat frame))
        ((and (pair? pat) (pair? dat))
         (pattern-match (cdr pat)
                        (cdr dat)
                        (pattern-match (car pat)
                                       (car dat)
                                       frame)))
        (else 'failed)))

(define (extend-if-consistent var dat frame)
  (let ((binding (binding-in-frame var frame)))
    (if binding
        (pattern-match (binding-value binding) dat frame)
        (extend var dat frame))))

;;;SECTION 4.4.4.4
;;;Rules and Unification

(define (apply-rules pattern frame)
  (let ((rules (fetch-rules pattern frame)))
    (lambda (succeed fail)
      (define (try-next choices)
        (if (null? choices)
            (fail)
            ((apply-a-rule (car choices) pattern frame)
             succeed
             (lambda ()
               (try-next (cdr choices))))))
      (try-next rules))))

(define (apply-a-rule rule query-pattern query-frame)
  (let ((clean-rule (rename-variables-in rule)))
    (let ((unify-result (unify-match query-pattern
                                     (conclusion clean-rule)
                                     query-frame)))
      (lambda (succeed fail)
        (if (eq? unify-result 'failed)
            (fail)
            ((analyze (rule-body clean-rule) unify-result)
             succeed
             fail))))))

(define (rename-variables-in rule)
  (let ((rule-application-id (new-rule-application-id)))
    (define (tree-walk exp)
      (cond ((var? exp)
             (make-new-variable exp rule-application-id))
            ((pair? exp)
             (cons (tree-walk (car exp))
                   (tree-walk (cdr exp))))
            (else exp)))
    (tree-walk rule)))

(define (unify-match p1 p2 frame)
  (cond ((eq? frame 'failed) 'failed)
        ((equal? p1 p2) frame)
        ((var? p1) (extend-if-possible p1 p2 frame))
        ((var? p2) (extend-if-possible p2 p1 frame)) ; {\em ; ***}
        ((and (pair? p1) (pair? p2))
         (unify-match (cdr p1)
                      (cdr p2)
                      (unify-match (car p1)
                                   (car p2)
                                   frame)))
        (else 'failed)))

(define (extend-if-possible var val frame)
  (let ((binding (binding-in-frame var frame)))
    (cond (binding
            (unify-match
              (binding-value binding) val frame))
          ((var? val)                     ; {\em ; ***}
           (let ((binding (binding-in-frame val frame)))
             (if binding
                 (unify-match
                   var (binding-value binding) frame)
                 (extend var val frame))))
          ((depends-on? val var frame)    ; {\em ; ***}
           'failed)
          (else (extend var val frame)))))

(define (depends-on? exp var frame)
  (define (tree-walk e)
    (cond ((var? e)
           (if (equal? var e)
               true
               (let ((b (binding-in-frame e frame)))
                 (if b
                     (tree-walk (binding-value b))
                     false))))
          ((pair? e)
           (or (tree-walk (car e))
               (tree-walk (cdr e))))
          (else false)))
  (tree-walk exp))

;;;SECTION 4.4.4.5
;;;Maintaining the Data Base

(define THE-ASSERTIONS '())

(define (fetch-assertions pattern frame)
  (if (use-index? pattern)
      (get-indexed-assertions pattern)
      (get-all-assertions)))

(define (get-all-assertions) THE-ASSERTIONS)

(define (get-indexed-assertions pattern)
  (get-record (index-key-of pattern) 'assertion-stream))

(define (get-record key1 key2)
  (let ((s (get key1 key2)))
    (if s s '())))

(define THE-RULES '())

(define (fetch-rules pattern frame)
  (if (use-index? pattern)
      (get-indexed-rules pattern)
      (get-all-rules)))

(define (get-all-rules) THE-RULES)

(define (get-indexed-rules pattern)
  (append
    (get-record (index-key-of pattern) 'rule-stream)
    (get-record '? 'rule-stream)))

(define (add-rule-or-assertion! assertion)
  (if (rule? assertion)
      (add-rule! assertion)
      (add-assertion! assertion)))

(define (add-assertion! assertion)
  (store-assertion-in-index assertion)
  (let ((old-assertions THE-ASSERTIONS))
    (set! THE-ASSERTIONS
          (cons assertion old-assertions))
    'ok))

(define (add-rule! rule)
  (store-rule-in-index rule)
  (let ((old-rules THE-RULES))
    (set! THE-RULES (cons rule old-rules))
    'ok))

(define (store-assertion-in-index assertion)
  (cond ((indexable? assertion)
         (let ((key (index-key-of assertion)))
           (let ((current-assertion-stream
                   (get-record key 'assertion-stream)))
             (put key
                  'assertion-stream
                  (cons assertion current-assertion-stream)))))))

(define (store-rule-in-index rule)
  (let ((pattern (conclusion rule)))
    (cond ((indexable? pattern)
           (let ((key (index-key-of pattern)))
             (let ((current-rule-stream
                     (get-record key 'rule-stream)))
               (put key
                    'rule-stream
                    (cons rule current-rule-stream))))))))

(define (indexable? pat)
  (or (constant-symbol? (car pat))
      (var? (car pat))))

(define (index-key-of pat)
  (let ((key (car pat)))
    (if (var? key) '? key)))

(define (use-index? pat)
  (constant-symbol? (car pat)))

;;;Query syntax procedures
(define (type exp)
  (if (pair? exp)
      (car exp)
      (error "Unknown expression TYPE" exp)))

(define (contents exp)
  (if (pair? exp)
      (cdr exp)
      (error "Unknown expression CONTENTS" exp)))

(define (assertion-to-be-added? exp)
  (eq? (type exp) 'assert!))

(define (add-assertion-body exp)
  (car (contents exp)))

(define (empty-conjunction? exps) (null? exps))
(define (first-conjunct exps) (car exps))
(define (rest-conjuncts exps) (cdr exps))

(define (empty-disjunction? exps) (null? exps))
(define (first-disjunct exps) (car exps))
(define (rest-disjuncts exps) (cdr exps))

(define (negated-query exps) (car exps))

(define (predicate exps) (car exps))
(define (args exps) (cdr exps))


(define (rule? statement)
  (tagged-list? statement 'rule))

(define (conclusion rule) (cadr rule))

(define (rule-body rule)
  (if (null? (cddr rule))
      '(always-true)
      (caddr rule)))

(define (query-syntax-process exp)
  (map-over-symbols expand-question-mark exp))

(define (map-over-symbols proc exp)
  (cond ((pair? exp)
         (cons (map-over-symbols proc (car exp))
               (map-over-symbols proc (cdr exp))))
        ((symbol? exp) (proc exp))
        (else exp)))

(define (expand-question-mark symbol)
  (let ((chars (symbol->string symbol)))
    (if (string=? (substring chars 0 1) "?")
        (list '?
              (string->symbol
                (substring chars 1 (string-length chars))))
        symbol)))

(define (var? exp)
  (tagged-list? exp '?))

(define (constant-symbol? exp) (symbol? exp))

(define rule-counter 0)

(define (new-rule-application-id)
  (set! rule-counter (+ 1 rule-counter))
  rule-counter)

(define (make-new-variable var rule-application-id)
  (cons '? (cons rule-application-id (cdr var))))

(define (contract-question-mark variable)
  (string->symbol
    (string-append "?" 
                   (if (number? (cadr variable))
                       (string-append (symbol->string (caddr variable))
                                      "-"
                                      (number->string (cadr variable)))
                       (symbol->string (cadr variable))))))


;;;SECTION 4.4.4.8
;;;Frames and bindings
(define (make-binding variable value)
  (cons variable value))

(define (binding-variable binding)
  (car binding))

(define (binding-value binding)
  (cdr binding))


(define (binding-in-frame variable frame)
  (assoc variable frame))

(define (extend variable value frame)
  (cons (make-binding variable value) frame))


;;;;From Section 4.1

(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))

(define (prompt-for-input string)
  (newline) (newline) (display string) (newline))


;;;;Stream support from Chapter 3
(define (display-line x)
  (newline)
  (display x))

;; put get 简单实现
(define *op-table* (make-hash))

(define (put op type proc)
  (hash-set! *op-table* (list op type) proc))

(define (get op type)
  (hash-ref *op-table* (list op type) #f))

(define (initialize-data-base rules-and-assertions)
  (define (deal-out r-and-a rules assertions)
    (cond ((null? r-and-a)
           (set! THE-ASSERTIONS assertions)
           (set! THE-RULES rules)
           'done)
          (else
            (let ((s (query-syntax-process (car r-and-a))))
              (cond ((rule? s)
                     (store-rule-in-index s)
                     (deal-out (cdr r-and-a)
                               (cons s rules)
                               assertions))
                    (else
                      (store-assertion-in-index s)
                      (deal-out (cdr r-and-a)
                                rules
                                (cons s assertions))))))))
  (deal-out rules-and-assertions '() '()))

;; Do following to reinit the data base from microshaft-data-base
;;  in Scheme (not in the query driver loop)
;; (initialize-data-base microshaft-data-base)

(define microshaft-data-base
  '(
    ;; from section 4.4.1
    (address (Bitdiddle Ben) (Slumerville (Ridge Road) 10))
    (job (Bitdiddle Ben) (computer wizard))
    (salary (Bitdiddle Ben) 60000)
    
    (address (Hacker Alyssa P) (Cambridge (Mass Ave) 78))
    (job (Hacker Alyssa P) (computer programmer))
    (salary (Hacker Alyssa P) 40000)
    (supervisor (Hacker Alyssa P) (Bitdiddle Ben))
    
    (address (Fect Cy D) (Cambridge (Ames Street) 3))
    (job (Fect Cy D) (computer programmer))
    (salary (Fect Cy D) 35000)
    (supervisor (Fect Cy D) (Bitdiddle Ben))
    
    (address (Tweakit Lem E) (Boston (Bay State Road) 22))
    (job (Tweakit Lem E) (computer technician))
    (salary (Tweakit Lem E) 25000)
    (supervisor (Tweakit Lem E) (Bitdiddle Ben))
    
    (address (Reasoner Louis) (Slumerville (Pine Tree Road) 80))
    (job (Reasoner Louis) (computer programmer trainee))
    (salary (Reasoner Louis) 30000)
    (supervisor (Reasoner Louis) (Hacker Alyssa P))
    
    (supervisor (Bitdiddle Ben) (Warbucks Oliver))
    
    (address (Warbucks Oliver) (Swellesley (Top Heap Road)))
    (job (Warbucks Oliver) (administration big wheel))
    (salary (Warbucks Oliver) 150000)
    
    (address (Scrooge Eben) (Weston (Shady Lane) 10))
    (job (Scrooge Eben) (accounting chief accountant))
    (salary (Scrooge Eben) 75000)
    (supervisor (Scrooge Eben) (Warbucks Oliver))
    
    (address (Cratchet Robert) (Allston (N Harvard Street) 16))
    (job (Cratchet Robert) (accounting scrivener))
    (salary (Cratchet Robert) 18000)
    (supervisor (Cratchet Robert) (Scrooge Eben))
    
    (address (Aull DeWitt) (Slumerville (Onion Square) 5))
    (job (Aull DeWitt) (administration secretary))
    (salary (Aull DeWitt) 25000)
    (supervisor (Aull DeWitt) (Warbucks Oliver))
    
    (can-do-job (computer wizard) (computer programmer))
    (can-do-job (computer wizard) (computer technician))
    (can-do-job (computer programmer) (computer programmer trainee))
    (can-do-job (administration secretary) (administration big wheel))
    
    ;; 练习 4.57
    (rule (can-replace ?person-1 ?person-2)
          (and (job ?person-1 ?job-1)
               (job ?person-2 ?job-2)
               (not (same ?person-1 ?person-2))
               (or (same ?job-1 ?job-2)
                   (can-do-job ?job-1 ?job-2))))
    
    ;; 练习 4.58
    (rule (big-shot ?person ?division)
          (and (job ?person (?division . ?job-type))
               (or (not (supervisor ?person ?boss))
                   (and (supervisor ?person ?boss)
                        (not (job ?boss (?division . ?boss-job-type)))))))
    
    ;; 练习 4.59
    (meeting accounting (Monday 9am))
    (meeting administration (Monday 10am))
    (meeting computer (Wednesday 3pm))
    (meeting administration (Friday 1pm))
    (meeting whole-company (Wednesday 4pm))
    
    (rule (meeting-time ?person ?day-and-time)
          (or (meeting whole-company ?day-and-time)
              (and (job ?person (?division . ?type))
                   (meeting ?division ?day-and-time))))
    
    (rule (lives-near ?person-1 ?person-2)
          (and (address ?person-1 (?town . ?rest-1))
               (address ?person-2 (?town . ?rest-2))
               (not (same ?person-1 ?person-2))))
    
    (rule (same ?x ?x))
    
    (rule (wheel ?person)
          (and (supervisor ?middle-manager ?person)
               (supervisor ?x ?middle-manager)))
    
    (rule (outranked-by ?staff-person ?boss)
          (or (supervisor ?staff-person ?boss)
              (and (supervisor ?staff-person ?middle-manager)
                   (outranked-by ?middle-manager ?boss))))
    ))

(define (easy-qeval q)
  (display-line ";;; Query input:")
  (display-line q)
  (newline)
  (display-line ";;; Query results:")
  (qeval (query-syntax-process q) 
         '()
         (lambda (frame next-alternative)
           (display-line (instantiate (query-syntax-process q) 
                                      frame
                                      (lambda (v f)
                                        (contract-question-mark v))))
           (next-alternative))
         (lambda () 'done))
  (newline))

(define (easy-qeval-test)
  (easy-qeval '(supervisor ?x (Bitdiddle Ben)))
  (easy-qeval '(job ?x (accounting . ?type)))
  (easy-qeval '(address ?x (Slumerville . ?where)))
  (easy-qeval '(and (supervisor ?person (Bitdiddle Ben))
                    (address ?person ?where)))
  
  (easy-qeval '(and (salary (Bitdiddle Ben) ?ben-salary)
                    (salary ?person ?person-salary)
                    (lisp-value < ?person-salary ?ben-salary)))
  
  (easy-qeval '(and (supervisor ?person ?boss)
                    (not (job ?boss (computer . ?type)))
                    (job ?boss ?boss-job)))
  (easy-qeval '(can-replace ?x (Fect Cy D))))

(#%require (only racket module*))
(module* main #f
         (initialize-data-base microshaft-data-base)
         ;(easy-qeval-test)
         (query-driver-loop)
         )

