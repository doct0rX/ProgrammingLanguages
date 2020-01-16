
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below


;; 1. function sequence that takes 3 arguments low, high, and stride, all assumed to be numbers.
;; Further assume stride is positive. sequence produces a list of numbers from low to high (including
;; low and possibly high) separated by stride and in sorted order.
(define (sequence low high stride)
  (if (> low high)
      null
      (cons low (sequence (+ low stride) high stride))))


;; 2. function string-append-map that takes a list of strings xs and a string suffix and returns a
;; list of strings. Each element of the output should be the corresponding element of the input appended
;; with suffix (with no extra space between the element and suffix).
(define (string-append-map xs suffix)
  (map (lambda (x) (string-append x suffix)) xs))

;; 3. function list-nth-mod that takes a list xs and a number n. If the number is negative,
;; terminate the computation with (error "list-nth-mod: negative number"). Else if the list is
;; empty, terminate the computation with (error "list-nth-mod: empty list"). Else return the ith
;; element of the list where we count from zero and i is the remainder produced when dividing n by the
;; list’s length.
(define (list-nth-mod xs n)
  (if (negative? n)
      (error "list-nth-mod: negative number")
      (if (empty? xs)
          (error "list-nth-mod: empty list")
          (remainder n (length xs)))))

;; 4. function stream-for-n-steps that takes a stream s and a number n. It returns a list holding
;; the first n values produced by s in order. Assume n is non-negative.
(define (stream-for-n-steps s n)
  (if (= n 0)
      null
      (cons (car (s)) (stream-for-n-steps (cdr (s)) (- n 1)))))

;; 5. stream funny-number-stream that is like the stream of natural numbers (i.e., 1, 2, 3, ...)
;; except numbers divisble by 5 are negated (i.e., 1, 2, 3, 4, -5, 6, 7, 8, 9, -10, 11, ...). Remember a stream
;; is a thunk that when called produces a pair. Here the car of the pair will be a number and the cdr will
;; be another stream.
(define funny-number-stream
  (letrec ([f (lambda (x) (cons (if (= (remainder x 5) 0) (- x) x)
                                (lambda () (f (+ x 1)))))])
    (lambda () (f 1))))
