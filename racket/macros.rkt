#lang racket
(define-syntax my-or
  (syntax-rules ()
    [(my-or p q)
     (if p #t q)]))

(my-or (> 10 3) (/ 1 0))

(define-syntax and
  (syntax-rules()
    [(and p q)
      (if p
          (if q #t #f) #f)]))

(and (< 10 3) (/ 1 0))

;(define-syntax cond
;  (syntax-rules()
;    [(cond args) (length args)]))
;;     (if (first (first args))
;;         (first (second args))
;;         (cond (rest args)))]))
;
;(cond `(1 2 3 4 5))

;(cond [1 2 3 4 5] [2])
     ;(list (list p q))

(define-syntax my-cond
  (syntax-rules (else)
    [(my-cond [else val]) val]
    [(my-cond [test val]) (if test val (void))]
    [(my-cond [test val] [test-1 val-1] ...)
     (if test val (my-cond [test-1 val-1] ...))]))



; Recursive macro for "or"
(define-syntax my-or-rec
  (syntax-rules ()
    [(my-or-rec p) p]
    [(my-or-rec p q ...)
     (if p #t (my-or-rec q ...))]))