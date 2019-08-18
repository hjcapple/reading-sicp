#lang racket

;; P98 - [memq]

(define (memq item x)
  (cond ((null? x) #f)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))

;;;;;;;;;;;;;;;;
(memq 'apple '(pear banana prune))
(memq 'apple '(x (apple sauce) y apple pear))

