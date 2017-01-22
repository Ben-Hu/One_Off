#lang racket
; Write a macro for "my-and"
(define-syntax my-and
  (syntax-rules ()
    [(my-and p q)
     (if p
         (if q
             #t 
             #f) #f)]))

(my-and (< 10 3) (/ 1 0))

; Write a macro for "my-cond"
(define-syntax my-cond
  (syntax-rules ()
    [(my-cond something)
     (void)]))