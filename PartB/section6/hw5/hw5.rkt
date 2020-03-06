;; Programming Languages, Homework 5

#lang racket
(provide (all-defined-out)) ;; so we can put tests in a second file

;; definition of structures for MUPL programs - Do NOT change
(struct var  (string) #:transparent)  ;; a variable, e.g., (var "foo")
(struct int  (num)    #:transparent)  ;; a constant number, e.g., (int 17)
(struct add  (e1 e2)  #:transparent)  ;; add two expressions
(struct ifgreater (e1 e2 e3 e4)    #:transparent) ;; if e1 > e2 then e3 else e4
(struct fun  (nameopt formal body) #:transparent) ;; a recursive(?) 1-argument function
(struct call (funexp actual)       #:transparent) ;; function call
(struct mlet (var e body) #:transparent) ;; a local binding (let var = e in body) 
(struct apair (e1 e2)     #:transparent) ;; make a new pair
(struct fst  (e)    #:transparent) ;; get first part of a pair
(struct snd  (e)    #:transparent) ;; get second part of a pair
(struct aunit ()    #:transparent) ;; unit value -- good for ending a list
(struct isaunit (e) #:transparent) ;; evaluate to 1 if e is unit else 0

;; a closure is not in "source" programs but /is/ a MUPL value; it is what functions evaluate to
(struct closure (env fun) #:transparent) 

;; Problem 1

;; (a) Racket function racketlist->mupllist that takes a Racket list and produces
;; an analogous mupl list with the same elements in the same order.
(define (racketlist->mupllist rktlst)
  (cond ((null? rktlst) (aunit))
        ((list? rktlst) (apair (car rktlst) (racketlist->mupllist (cdr rktlst))))
        (#t (error "wrong argument"))))

;; (b) Racket function mupllist->racketlist that takes a mupl list and produces an analogous Racket list
;; with the same elements in the same order.
(define (mupllist->racketlist mupllst)
  (cond ((aunit? mupllst) null)
        ((apair? mupllst) (cons (apair-e1 mupllst) (mupllist->racketlist (apair-e2 mupllst))))
        (#t (error "wrong argument"))))


;; Problem 2

;; lookup a variable in an environment
;; Do NOT change this function
(define (envlookup env str)
  (cond [(null? env) (error "unbound variable during evaluation" str)]
        [(equal? (car (car env)) str) (cdr (car env))]
        [#t (envlookup (cdr env) str)]))

;; Do NOT change the two cases given to you.  
;; DO add more cases for other kinds of MUPL expressions.
;; We will test eval-under-env by calling it directly even though
;; "in real life" it would be a helper function of eval-exp.
(define (eval-under-env e env)
  (cond [(var? e) 
         (envlookup env (var-string e))]
        [(add? e) 
         (let ([v1 (eval-under-env (add-e1 e) env)]
               [v2 (eval-under-env (add-e2 e) env)])
           (if (and (int? v1)
                    (int? v2))
               (int (+ (int-num v1) 
                       (int-num v2)))
               (error "MUPL addition applied to non-number")))]
        ;; adding my cases here
        [(int? e) e]
        [(closure? e) e]
        [(aunit? e) e]
        [(apair? e) (apair (eval-under-env (apair-e1 e) env) (eval-under-env (apair-e2 e) env))]
        [(ifgreater? e) (let ([v1 (eval-under-env (ifgreater-e1 e) env)]
                              [v2 (eval-under-env (ifgreater-e2 e) env)])
                          (if (and (int? v1) (int? v2))
                              (if (> (int-num v1) (int-num v2)) (eval-under-env (ifgreater-e3 e) env)
                                  (eval-under-env (ifgreater-e4 e) env))
                              (error "MUPL ifgreater applied to non-number")))]
        [(mlet? e) (eval-under-env (mlet-body e)
                                   (cons (cons (mlet-var e) (eval-under-env (mlet-e e) env)) env))]
        [(fst? e) (let ([val (eval-under-env (fst-e e) env)])
                    (if (apair? val) (apair-e1 val)
                        (error "MUPL fst applied to non-pair")))]
        [(snd? e) (let ([val (eval-under-env (snd-e e) env)])
                    (if (apair? val) (apair-e2 val)
                      (error "MUPL snd applied to non-pair")))]
        [(isaunit? e) (if (aunit? (eval-under-env (isaunit-e e) env)) (int 1) (int 0))]
        [(fun? e) (closure env e)]
        [(call? e) (let ([close (eval-under-env (call-funexp e) env)])
                     (if (closure? close)
                         (let ([fx (closure-fun close)])
                           (let ([arg (eval-under-env (call-actual e) env)])
                             (if (fun-nameopt fx);new env 
                                 (eval-under-env (fun-body fx) (cons (cons (fun-nameopt fx) close);then
                                                                     (cons (cons (fun-formal fx) arg)
                                                                           (closure-env close))))
                                 (eval-under-env (fun-body fx) (cons (cons (fun-formal fx) arg)
                                                                     (closure-env close))))))
                           (error "MUPL call applied to non-closure")))];else
        [#t (error (format "bad MUPL expression: ~v" e))]))

;; Do NOT change
(define (eval-exp e)
  (eval-under-env e null))
        
;; Problem 3

(define (ifaunit e1 e2 e3) (ifgreater (isaunit e1) (int 0) e2 e3))

(define (mlet* lstlst e2) (if (null? lstlst)
                              e2
                              (mlet (caar lstlst) (cdar lstlst) (mlet* (cdr lstlst) e2))))

(define (ifeq e1 e2 e3 e4) (mlet "_x" e1
                                 (mlet "_y" e2
                                       (if (equal? (var "_x") (var "_y"))
                                           e3
                                           e4))))

;; Problem 4

(define mupl-map
  (fun #f "fx"
       (fun "map" "lst"
            (ifaunit (var "lst") (var "lst")
                     (apair (call (var "fx") (fst (var "lst"))) (call (var "map") (snd (var "lst"))))))))

(define mupl-mapAddN 
  (mlet "map" mupl-map ;map is now in MUPL scope
        (fun #f "int"
             (fun #f "lst"
                  (call (call (var "map") (fun #f "element" (add (var "int") (var "element"))))
                        (var "lst"))))))

;; Challenge Problem

(struct fun-challenge (nameopt formal body freevars) #:transparent) ;; a recursive(?) 1-argument function

;; We will test this function directly, so it must do
;; as described in the assignment
(define (compute-free-vars e) "CHANGE")

;; Do NOT share code with eval-under-env because that will make
;; auto-grading and peer assessment more difficult, so
;; copy most of your interpreter here and make minor changes
(define (eval-under-env-c e env) "CHANGE")

;; Do NOT change this
(define (eval-exp-c e)
  (eval-under-env-c (compute-free-vars e) null))
