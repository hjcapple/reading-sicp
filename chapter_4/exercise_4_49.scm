#lang sicp

;; P296 - [练习 4.49]

(#%require "ambeval.scm")

(easy-ambeval 10 '(begin

(define (require p)
  (if (not p) (amb)))

(define nouns '(noun student professor cat class))
(define verbs '(verb studies lectures eats sleeps))
(define articles '(article the a))
(define prepositions '(prep for to in by with))

(define (parse-sentence)
  (list 'sentence
        (parse-noun-phrase)
        (parse-verb-phrase)))

(define (parse-noun-phrase)
  (define (maybe-extend noun-phrase)
    (amb noun-phrase
         (maybe-extend (list 'noun-phrase
                             noun-phrase
                             (parse-prepositional-phrase)))))
  (maybe-extend (parse-simple-noun-phrase)))

(define (parse-prepositional-phrase)
  (list 'prep-phrase
        (parse-word prepositions)
        (parse-noun-phrase)))

(define (parse-verb-phrase)
  (define (maybe-extend verb-phrase)
    (amb verb-phrase
         (maybe-extend (list 'verb-phrase
                             verb-phrase
                             (parse-prepositional-phrase)))))
  (maybe-extend (parse-word verbs)))

(define (parse-simple-noun-phrase)
  (list 'simple-noun-phrase
        (parse-word articles)
        (parse-word nouns)))

(define (amb-list lst) 
  (if (null? lst) 
      (amb) 
      (amb (car lst) (amb-list (cdr lst))))) 

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

(define (parse-word word-list)
  (require (not (null? *unparsed*)))
  (set! *unparsed* (cdr *unparsed*))
  (let ((word (amb-list (cdr word-list))))
    (set! *sentence* (append *sentence* (list word)))
    (list (car word-list) word)))

(define *unparsed* '())
(define *sentence* '())

(define (parse input)
  (set! *sentence* '())
  (set! *unparsed* input)
  (let ((sent (parse-sentence)))
    (require (null? *unparsed*))
    *sentence*))

))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (print-list lst)
  (for-each (lambda (x) (display x) (newline)) lst))

(print-list (easy-ambeval 15 '(begin
                                (parse '(1 2 3))
                                )))

(print-list (easy-ambeval 15 '(begin
                                (parse '(1 2 3 4 5 6 7 8 9))
                                )))


