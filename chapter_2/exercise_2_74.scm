#lang racket

;; P126 - [练习 2.74]

; 这道题不是很明白，只能稍微模拟一下。
; 按照我理解，这道题主要是考察数据分发。
; get-record、get-salary、find-employee-record 的实现中，根据公司名字，将函数分派到不同的
; 公司进行实现。这样不管子公司内部，人事文件格式具体如何，一旦实现了标准的函数接口。总公司都可以获取到
; 统一数据格式。
; 假如并购了新公司，新公司也需要实现这些标准的数据接口，进行安装。总公司的查询系统实现也不需要变动。
; 测试代码中，安装了 companyA 和 companyB。只是接口没有具体实现，只是打印一些输出信息，知道函数被正确调用了。

;;;;;;;;;;
;; put get 简单实现
(define *op-table* (make-hash))

(define (put op type proc)
  (hash-set! *op-table* (list op type) proc))

(define (get op type)
  (hash-ref *op-table* (list op type) #f))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (get-record employee subcompany)
  ((get 'get-record subcompany) employee))

(define (get-salary employee subcompany)
  ((get 'get-salary subcompany) employee))

(define (find-employee-record employee subcompanies)
  (if (null? subcompanies)
      #f 
      (let ((ret ((get 'find-employee-record (car subcompanies)) employee)))
        (if ret
            ret 
            (find-employee-record employee (cdr subcompanies))))))
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (install-companyA-package)
  (define (get-record employee)
    (display "call companyA get-record")
    (newline)
    (list employee 1985))
  
  (define (get-salary employee)
    (display "call companyA get-salary")
    (newline)
    (list employee 20000))
  
  (define (find-employee-record employee)
    (display "call companyA find-employee-record")
    (newline)
    (if (eq? employee 'Tom)
        (list employee 1985)
        #f))
  
  (put 'get-record 'companyA get-record)
  (put 'get-salary 'companyA get-salary)
  (put 'find-employee-record 'companyA find-employee-record)
  'done)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (install-companyB-package)
  (define (get-record employee)
    (display "call companyB get-record")
    (newline)
    (list employee 1985))
  
  (define (get-salary employee)
    (display "call companyB get-salary")
    (newline)
    (list employee 20000))
  
  (define (find-employee-record employee)
    (display "call companyB find-employee-record")
    (newline)
    (if (eq? employee 'John)
        (list employee 1985)
        #f))
  
  (put 'get-record 'companyB get-record)
  (put 'get-salary 'companyB get-salary)
  (put 'find-employee-record 'companyB find-employee-record)
  'done)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(install-companyA-package)
(install-companyB-package)

(get-record 'Tom 'companyA)
(get-salary 'Tom 'companyA)

(get-record 'John 'companyB)
(get-salary 'John 'companyB)

(find-employee-record 'Tom '(companyB companyA))

; call companyA get-record
; '(Tom 1985)
; call companyA get-salary
; '(Tom 20000)
; call companyB get-record
; '(John 1985)
; call companyB get-salary
; '(John 20000)
; call companyB find-employee-record
; call companyA find-employee-record
; '(Tom 1985)

