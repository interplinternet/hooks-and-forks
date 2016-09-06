#lang racket
(provide (all-defined-out))
;---------------------------------------------------------------------------------------------------
#| FORKS |#
; [X -> Y] [Listof [N -> M]] -> Any -> Any

(define ((fork head . fns) arg)
  (apply head (map (λ (fn) (fn arg)) fns)))

(define-syntax-rule (define/fork name [head fns ...])
  (define name (fork head fns ...)))

(define (sum lon)
  (apply + lon))

; Compute the average of numbers on a list.
(define/fork average (/ sum length))

;---------------------------------------------------------------------------------------------------
#| HOOKS |#
(define ((hook1 f1 f2) arg)
  (f1 arg (f2 arg)))

(define-syntax-rule (define/hook1 name [fn1 fn2])
  (define name (hook1 fn1 fn2)))

; Number -> Boolean
(define/hook1 is-integer? (= floor))

(define ((hook2 f1 f2) arg1 arg2)
  (f1 arg1 (f2 arg2)))

(define-syntax-rule (define/hook2 name [fn1 fn2])
  (define name (hook2 fn1 fn2)))

; Determine whether a number is on the line y=x+3
(define/hook2 line (= (λ (x) (+ x 3)))) ;(line 3 4) => #f (line 7 4) => #t

(define ((hook f1 f2) . args)
  (apply f1 (append args (list (apply f2 args)))))

(define-syntax-rule (define/hook name [fn1 fn2])
  (define name (hook fn1 fn2)))

