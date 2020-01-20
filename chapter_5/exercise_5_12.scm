#lang sicp

;; P371 - 练习 5.12

(#%require "ch5support.scm")
(#%require "ch5-regsim.scm")

(define (make-machine register-names ops controller-text)
  (let ((machine (make-new-machine-dataset)))
    (for-each (lambda (register-name)
                ((machine 'allocate-register) register-name))
              register-names)
    ((machine 'install-operations) ops)    
    ((machine 'install-instruction-sequence)
     (assemble controller-text machine))
    machine))

(define (make-dataset)
  (let ((dataset '()))            
    (define (insert! datum)
      (if (not (is-in-dataset? datum))
          (set! dataset (cons datum dataset))))                
    (define (print)
      (for-each (lambda (inst)
                  (display inst)
                  (newline))
                dataset))    
    (define (is-in-dataset? datum)
      (cond ((symbol? datum) (memq datum dataset))
            ((list? datum) (member datum dataset))
            (else (error "Unknown data type -- IS-IN-dataset?" datum))))
    (define (dispatch message)
      (cond ((eq? message 'insert!) insert!)
            ((eq? message 'print) (print))
            (else (error "Unknown operation -- DATASET" message))))
    dispatch))

(define (insert-to-dataset! dataset datum)
  ((dataset 'insert!) datum))

(define (print-dataset dataset)
  (dataset 'print))

(define (make-new-machine-dataset)
  (let ((machine (make-new-machine))
        (inst-dataset-table '())
        (register-dataset-table '())
        (assign-dataset-table '()))
    
    (define (get-dataset dataset-table name set-fn)
      (let ((val (assoc name dataset-table)))
        (if val
            (cadr val)
            (let ((dataset (list name (make-dataset))))
              (set-fn (cons dataset dataset-table))
              (cadr dataset)))))
    
    (define (get-inst-dataset name)
      (get-dataset inst-dataset-table 
                   name 
                   (lambda (table) (set! inst-dataset-table table))))
    
    (define (get-register-dataset name)
      (get-dataset register-dataset-table 
                   name
                   (lambda (table) (set! register-dataset-table table))))
    
    (define (get-assign-dataset name)
      (get-dataset assign-dataset-table 
                   name
                   (lambda (table) (set! assign-dataset-table table))))
    
    (define (print-all-dataset-table)
      (define (print-dataset-table t name)
        (display name)
        (newline)
        (display "==============")
        (newline)
        (for-each (lambda (dataset)
                    (display (car dataset))
                    (display ": ")
                    (newline)
                    (print-dataset (cadr dataset))
                    (newline))
                  t))
      (print-dataset-table inst-dataset-table "Instructions: ")
      (print-dataset-table register-dataset-table "Register: ")
      (print-dataset-table assign-dataset-table "Assign: "))
    
    (define (dispatch message)
      (cond ((eq? message 'get-inst-dataset) get-inst-dataset)
            ((eq? message 'get-register-dataset) get-register-dataset)
            ((eq? message 'get-assign-dataset) get-assign-dataset)
            ((eq? message 'print-all-dataset-table) print-all-dataset-table)
            (else (machine message))))                      
    dispatch))

(define (insert-inst-to-dataset! machine inst)
  (let ((dataset ((machine 'get-inst-dataset) (car inst))))
    (insert-to-dataset! dataset inst)))

(define (insert-assign-to-dataset! machine inst)
  (let ((dataset ((machine 'get-assign-dataset) (assign-reg-name inst))))
    (insert-to-dataset! dataset (assign-value-exp inst))))

(define (insert-register-to-dataset! machine inst-name reg-name)
  (let ((dataset ((machine 'get-register-dataset) inst-name)))
    (insert-to-dataset! dataset reg-name)))

(redefine (make-execution-procedure inst labels machine
                                    pc flag stack ops)
  (cond ((eq? (car inst) 'assign)
         (make-assign-dataset inst machine labels ops pc))
        ((eq? (car inst) 'test)
         (insert-inst-to-dataset! machine inst)
         (make-test inst machine labels ops flag pc))
        ((eq? (car inst) 'branch)
         (insert-inst-to-dataset! machine inst)
         (make-branch inst machine labels flag pc))
        ((eq? (car inst) 'goto)
         (make-goto-dataset inst machine labels pc))
        ((eq? (car inst) 'save)
         (make-save-dataset inst machine stack pc))
        ((eq? (car inst) 'restore)
         (make-restore-dataset inst machine stack pc))
        ((eq? (car inst) 'perform)
         (insert-inst-to-dataset! machine inst)
         (make-perform inst machine labels ops pc))
        (else (error "Unknown instruction type -- ASSEMBLE"
                     inst))))

(define (make-assign-dataset inst machine labels ops pc)
  (insert-inst-to-dataset! machine inst)
  (insert-assign-to-dataset! machine inst)
  (make-assign inst machine labels ops pc))

(define (make-goto-dataset inst machine labels pc)
  (insert-inst-to-dataset! machine inst)
  (let ((dest (goto-dest inst)))
    (cond ((register-exp? dest) 
           (insert-register-to-dataset! machine 'goto (register-exp-reg dest)))))
  (make-goto inst machine labels pc))

(define (make-save-dataset inst machine stack pc)
  (insert-inst-to-dataset! machine inst)
  (insert-register-to-dataset! machine 'save (stack-inst-reg-name inst))
  (make-save inst machine stack pc))

(define (make-restore-dataset inst machine stack pc)
  (insert-inst-to-dataset! machine inst)
  (insert-register-to-dataset! machine 'restore (stack-inst-reg-name inst))
  (make-restore inst machine stack pc))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define fib-machine
  (make-machine
    '(continue n val)
    (list (list '< <)
          (list '- -)
          (list '+ +)
          )
    '(
      (assign continue (label fib-done))
      fib-loop
      (test (op <) (reg n) (const 2))
      (branch (label immediate-answer))
      ;; set up to compute Fib(n - 1)
      (save continue)
      (assign continue (label afterfib-n-1))
      (save n)                           ; save old value of n
      (assign n (op -) (reg n) (const 1)); clobber n to n - 1
      (goto (label fib-loop))            ; perform recursive call
      afterfib-n-1                         ; upon return, val contains Fib(n - 1)
      (restore n)
      (restore continue)
      ;; set up to compute Fib(n - 2)
      (assign n (op -) (reg n) (const 2))
      (save continue)
      (assign continue (label afterfib-n-2))
      (save val)                         ; save Fib(n - 1)
      (goto (label fib-loop))
      afterfib-n-2                         ; upon return, val contains Fib(n - 2)
      (assign n (reg val))               ; n now contains Fib(n - 2)
      (restore val)                      ; val now contains Fib(n - 1)
      (restore continue)
      (assign val                        ;  Fib(n - 1) +  Fib(n - 2)
              (op +) (reg val) (reg n)) 
      (goto (reg continue))              ; return to caller, answer is in val
      immediate-answer
      (assign val (reg n))               ; base case:  Fib(n) = n
      (goto (reg continue))
      fib-done
      )))

(set-register-contents! fib-machine 'n 10)
(start fib-machine)
(get-register-contents fib-machine 'val)
((fib-machine 'print-all-dataset-table))


