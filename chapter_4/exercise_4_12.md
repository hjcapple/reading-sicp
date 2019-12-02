## P263 - [练习 4.12]

在 [mceval.scm](./mceval.scm) 的基础上修改测试。修改如下：

``` Scheme
(define (scan-frame frame var null-op found-op)
  (define (scan vars vals)
    (cond ((null? vars)
           (null-op))
          ((eq? var (car vars))
           (found-op vars vals))
          (else (scan (cdr vars) (cdr vals)))))
  (scan (frame-variables frame)
        (frame-values frame)))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan-frame frame 
                      var
                      (lambda () (env-loop (enclosing-environment env)))
                      (lambda (vars vals) (car vals))))))
  (env-loop env))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (if (eq? env the-empty-environment)
        (error "Unbound variable -- SET!" var)
        (let ((frame (first-frame env)))
          (scan-frame frame
                      var 
                      (lambda () (env-loop (enclosing-environment env)))
                      (lambda (vars vals) (set-car! vals val))))))
  (env-loop env))

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (scan-frame frame
                var
                (lambda () (add-binding-to-frame! var val frame))
                (lambda (vars vals) (set-car! vals val)))))                   
```
