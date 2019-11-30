## P263 - [练习 4.11]

在 [mceval.scm](./mceval.scm) 的基础上修改测试。修改如下：

``` Scheme
(define (make-frame variables values)
  (cons 'frame 
        (map cons variables values)))

(define (frame-pairs frame) (cdr frame))

(define (add-binding-to-frame! var val frame)
  (set-cdr! frame (cons (cons var val)
                        (frame-pairs frame))))
                        
(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan pairs)
      (cond ((null? pairs)
             (env-loop (enclosing-environment env)))
            ((eq? var (car (car pairs)))
             (cdr (car pairs)))
            (else (scan (cdr pairs)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-pairs frame)))))
  (env-loop env))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan pairs)
      (cond ((null? pairs)
             (env-loop (enclosing-environment env)))
            ((eq? var (car (car pairs)))
             (set-cdr! (car pairs) val))
            (else (scan (cdr pairs)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable -- SET!" var)
        (let ((frame (first-frame env)))
          (scan (frame-pairs frame)))))
  (env-loop env))

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (define (scan pairs)
      (cond ((null? pairs)
             (add-binding-to-frame! var val frame))
            ((eq? var (car (car pairs)))
             (set-cdr! (car pairs) val))
            (else (scan (cdr pairs)))))
    (scan (frame-pairs frame))))                        
```

