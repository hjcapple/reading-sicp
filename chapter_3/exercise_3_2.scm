#lang racket

;; P154 - [练习 3.2]

(define (make-monitored f)
  (let ((call-count 0))
    (define (do-call args)
      (set! call-count (+ call-count 1))
      (apply f args))
    
    (define (dispatch . args)
      (if (= (length args) 1)
          (cond ((eq? 'how-many-call? (car args)) call-count)
                ((eq? 'reset-count (car args)) (set! call-count 0))
                (else (do-call args)))
          (do-call args)))
    
    dispatch))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define s (make-monitored sqrt))
(s 100)
(s 'how-many-call?)

(module* test #f
  (require rackunit)
  (define s-sqrt (make-monitored sqrt))    
  (define s-sum (make-monitored +))
  
  ;; 测试 1 个参数
  (check-equal? (s-sqrt 'how-many-call?) 0)
  (check-equal? (s-sqrt 100) 10)
  (check-equal? (s-sqrt 'how-many-call?) 1)
  (check-equal? (s-sum 'how-many-call?) 0)
  (s-sqrt 'reset-count)
  (check-equal? (s-sqrt 'how-many-call?) 0)
  
  ;; 测试多个参数
  (check-equal? (s-sum 10 20 30 40) 100)
  (check-equal? (s-sum 10 20 30) 60)
  (check-equal? (s-sum 'how-many-call?) 2)
  
  ; 测试 0 个参数
  (define (helloworld) (println "helloworld"))
  (define s-helloworld (make-monitored helloworld))
  (s-helloworld)
  (check-equal? (s-helloworld 'how-many-call?) 1)
)


