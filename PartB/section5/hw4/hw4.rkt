
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

;; 6. stream dan-then-dog, where the elements of the stream alternate between the strings "dan.jpg"
;; and "dog.jpg" (starting with "dan.jpg"). More specifically, dan-then-dog should be a thunk that
;; when called produces a pair of "dan.jpg" and a thunk that when called produces a pair of "dog.jpg"
;; and a thunk that when called... etc.
(define dan-then-dog
  (letrec ([f (lambda (s) (if s
                              (cons "dan.jpg" (lambda () (f #f)))
                              (cons "dog.jpg" (lambda () (f #t)))))])
    (lambda () (f #t))))

;; 7. function stream-add-zero that takes a stream s and returns another stream. If s would
;; produce v for its ith element, then (stream-add-zero s) would produce the pair (0 . v) for its ith element.
(define (stream-add-zero s)
  (lambda ()
    (let ([pr (s)])
      (cons (cons 0 (car pr)) (stream-add-zero (cdr pr))))))

;; 8. function cycle-lists that takes two lists xs and ys and returns a stream. The lists may or
;; may not be the same length, but assume they are both non-empty. The elements produced by the
;; stream are pairs where the first part is from xs and the second part is from ys. The stream cycles
;; forever through the lists. For example, if xs is ’(1 2 3) and ys is ’("a" "b"), then the stream
;; would produce, (1 . "a"), (2 . "b"), (3 . "a"), (1 . "b"), (2 . "a"), (3 . "b"), (1 . "a"),
;; (2 . "b"), etc.
(define (cycle-lists xs zs)
  (letrec ([f (lambda (n)
                (let ([x (list-ref xs (list-nth-mod xs n))]
                      (z (list-ref zs (list-nth-mod zs n))))
                  (cons (cons x z) (lambda () (f (+ n 1))))))])
    (lambda () (f 0))))

;; 9. function vector-assoc that takes a value v and a vector vec. It should behave like Racket’s
;; assoc library function except (1) it processes a vector (Racket’s name for an array) instead of a list,
;; (2) it allows vector elements not to be pairs in which case it skips them, and (3) it always takes exactly
;; two arguments. Process the vector elements in order starting from 0.
;; You must use library functions vector-length, vector-ref, and equal?.
;; Return #f if no vector element is a pair with a car fieldequal to v, else return the first pair with an equal car field.
(define (vector-assoc v vec)
   (letrec ([f (lambda (n)
                 (if (>= n (vector-length vec))
                     #f
                     (let ([ith (vector-ref vec n)])
                       (if (and (pair? ith) (equal? (car ith) v))
                           ith
                           (f (add1 n))))))])
  (f 0)))

;; 10. function cached-assoc that takes a list xs and a number n and returns a function that takes
;; one argument v and returns the same thing that (assoc v xs) would return. However, you should
;; use an n-element cache of recent results to possibly make this function faster than just calling assoc
;; (if xs is long and a few elements are returned often). The cache must be a Racket vector of length n
;; that is created by the call to cached-assoc (use Racket library function vector or make-vector) and
;; used-and-possibly-mutated each time the function returned by cached-assoc is called. Assume n is positive.
(define (cached-assoc xs n)
  (letrec ([memo (make-vector n #f)]
           [pos 0])
    (lambda (v)
      (or (vector-assoc v memo)
          (let ([new-ans (assoc v xs)])
            (and new-ans
                 (begin
                   (vector-set! memo pos new-ans)
                   (set! pos (remainder (add1 pos) n))
                   new-ans)))))))

;; 11. (Challenge Problem:) macro that is used like (while-less e1 do e2) where e1 and e2
;; are expressions and while-less and do are syntax (keywords). The macro should do the following:
;; • It evaluates e1 exactly once.
;; • It evaluates e2 at least once.
;; • It keeps evaluating e2 until and only until the result is not a number less than the result of the evaluation of e1.
;; • Assuming evaluation terminates, the result is #t.
;; • Assume e1 and e2 produce numbers; your macro can do anything or fail mysteriously otherwise.
(define-syntax while-less
  (syntax-rules (do)
    [(while e1 do e2)
     (letrec ([val-of-e1 e1]
              [loop (lambda ()
                      (if (>= e2 val-of-e1)
                          #t
                          (loop)))])
    (loop))]))