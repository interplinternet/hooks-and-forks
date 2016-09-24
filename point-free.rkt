#lang racket
(provide fork hook hook1 hook2 define/fork define/hook define/hook1 define/hook2)
;---------------------------------------------------------------------------------------------------
#| FORKS |#
; [X -> Y] [Listof [N -> M]] -> Any -> Any
(define ((fork head . fns) arg)
  (apply head (map (λ (fn) (fn arg)) fns)))
;---------------------------------------------------------------------------------------------------
#| HOOKS |#
; [X Y -> Z] [N -> M] -> Any -> Any
(define ((hook1 f1 f2) arg)
  (f1 arg (f2 arg)))

; [X Y -> Z] [N -> M] -> Any Any -> Any
(define ((hook2 f1 f2) arg1 arg2)
  (f1 arg1 (f2 arg2)))

;[X ... -> Z] [A .... -> C] -> [Listof Any] -> Any
(define ((hook f1 f2) . args)
  (apply f1 (append args (list (apply f2 args)))))
;---------------------------------------------------------------------------------------------------
#| SYNTAX |#
(define-syntax-rule (define/fork name [head fns ...])
  (define name (fork head fns ...)))

(define-syntax-rule (define/hook name [fn1 fn2])
  (define name (hook fn1 fn2)))

(define-syntax-rule (define/hook1 name [fn1 fn2])
  (define name (hook1 fn1 fn2)))

(define-syntax-rule (define/hook2 name [fn1 fn2])
  (define name (hook2 fn1 fn2)))
;---------------------------------------------------------------------------------------------------
#| EXAMPLES |#
(define (sum lon)
  (apply + lon))

; Compute the average of numbers on a list.
(define/fork average (/ sum length))

; Number -> Boolean
(define/hook1 is-integer? (= floor))

; Determine whether a number is on the line y=x+3
(define/hook2 line (= (λ (x) (+ x 3)))) ;(line 3 4) => #f (line 7 4) => #t
