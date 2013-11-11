(define (sum term a next b)
  ;; a -> lower bounds
  ;; b -> upper bounds
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b)) ))
(define (inc x) (+ x 1))

(define (cube x) (* x x x))

(define (simpson f a b n)
  (define h (/ (- b a) n))
  (define (g x) (f (+ a (* x h))))
  (define (simp-term k)
    (* (if (even? k) 2 4)
       (g k)))

  (* (/ h 3.0)
     (+ (g 0)
        (g n)
        (sum simp-term 1 inc (- n 1)))) )
