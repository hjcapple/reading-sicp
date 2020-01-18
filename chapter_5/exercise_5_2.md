## P348 - [练习 5.2]

``` Scheme
(controller
  (assign product (const 1))
  (assign counter (const 1))

test-n
  (test (op >) (reg counter) (reg n))
  (branch (label fact-done))
  (assign product (op *) (reg counter) (reg product))
  (assign counter (op +) (reg counter) (const 1))
  (goto (label test-n))
  
fact-done)
```
