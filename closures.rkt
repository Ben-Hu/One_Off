#lang racket
(require test-engine/racket-tests)

; Some globals
(define x 20)
(define y "Hi")

; A function with a parameter shadowing the global definition
(define (f x) (+ x x))
; TODO: Uncomment and fill in the expected value
(check-expect (f 2) 4)

; A function that returns a function, using its parameter
(define (maker n)
  (lambda (m) (- n m)))
(check-expect ((maker 3) 10) -7 )

; A function that returns a function, using a global variable
(define (maker-2 n)
  (lambda (m) (- x m)))
(check-expect ((maker-2 3) 10) 10)

; A function that returns a function, using a local variable.
; Also, variable shadowing (why?)
(define (maker-3 n y)
  (let ([y "byeee"])
    (lambda (m) (+ n m (string-length y)))))
(check-expect ((maker-3 3 15) 20) 28)

; A function that returns a higher-order function
(define (maker-4 n)
  (lambda (f x)
    (f (+ x n))))
; TODO: write your own test(s)!
(check-expect ((maker-4 4) (lambda (z) (+ z 1)) 4) 9)

; A function in a let
(define let-ex 
  (let ([x 6])
    (lambda (y) (- x y))))
(check-expect (let-ex 8) -2)

; A function in a let, with shadowing
(define let-ex-2
  (let* ([x 15]
         [y (- x 6)])
    (lambda (y) (- x y))))
(check-expect (let-ex-2 3) 12)

; Combining everything
(define let-ex-3
  (let ([a 15])
    (lambda (y)
      (let ([b (+ a 5)]
            [a 11]) ;1
        (lambda (z) (+ (- z y) (- a b)))))))
(check-expect ((let-ex-3 1) 0) -10)

; Last one - lexical vs. dynamic scope
(define const 10)
(define (let-ex-4 y)
  (lambda (z) (+ y (- z const))))

 (check-expect
    (let ([const 1]
          [y 2]
          [z 3])
      ((let-ex-4 1) 5))
    -4)


(test)
