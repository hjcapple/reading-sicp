// clang-format off
// 这个文件直接被 C 语言 #include, 载入到环境中，用于实现基础的 Scheme 函数

#define StdLib(x) #x

static const char *scheme_libs =

StdLib(
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



