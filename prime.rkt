#lang racket
(require test-engine/racket-tests)

#| We say that m is a factor of n if the remainder when n is divided by m is 0.
A prime number is a natural number > 1 whose only factors are 1 and itself.

Implement the functions below to create a prime-listing function.
|#


#|
(factor? m n)
  m,n: positive natural numbers

  Returns true if and only if m is a factor of n.
|#
(define (factor? m n) 
  (if (equal? m 0) 
      #f
  (equal? (modulo n m) 0)))

 ;Tests
; (check-expect (factor? 2 6) #t)
; (check-expect (factor? 1 6) #t)
; (check-expect (factor? 6 2) #f)
; (check-expect (factor? 3 10) #f)
; (test)

#|
(factors n)
  n: positive natural number

  Returns a list of all factors of n, in increasing order.

HINT: use (range n) to return a list of numbers from 0 to n-1.
|#
(define (factors n) 
  (filter (lambda (x) (factor? x n))  (range (+ 1 n))))

; Tests
; (check-expect (factors 5) '(1 5))
; (check-expect (factors 12) '(1 2 3 4 6 12))
; (check-expect (factors 1) '(1))
; (test)

#|
(prime? n)
  n: positive natural number

  Returns true if and only if n is prime.
|#
(define (prime? n) 
  (equal? (length (factors n)) 2)) 

; Tests
; (check-expect (prime? 2) #t)
; (check-expect (prime? 10) #f)
; (test)

#|
(primes-up-to n)
  n: positive natural number

  Returns a list of all prime numbers up to and including n.
|#

(define (primes-up-to n)
  (filter prime? (range (+ n 1))))
  
(define (min-factors n [acc 0] [num 0])
  (cond [(> acc 2) #f]
        [(and (< num (+ n 1)) (factor? num n) (min-factors n (+ acc 1) (+ num 1)))]
        [(and (equal? num n) (< acc 3)) #t]
        [(and (equal? num n) (> acc 2)) #f] 
        [else (min-factors n acc (+ num 1))]))

(min-factors 4)
; 1
; 

    
;(define (optimus-prime lst n)
;  (map (lambda (num) (factor? num n)) lst))
  
;
  
;(define (extra-factors n)
;  (if 
;
;(define (primes-up-to n)
; Tests
; (check-expect (primes-up-to 20) '(2 3 5 7 11 13 17 19))
;  (check-expect (primes-up-to 2) '(2))
;   (check-expect (primes-up-to 30) '(2 3 5 7 11 13 17 19 23 29))
; (test)

#| BONUS!
The above implementation we've guided you through is quite inefficient:
at every number, you calculate *all* of its factors.

Improve your algorithm for primes-up-to. :) |#
