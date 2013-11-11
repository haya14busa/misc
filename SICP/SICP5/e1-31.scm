;; a
(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (factorial n)
  (product (lambda (x) x) 1 (lambda (x) (+ x 1)) n))

(define (pi n)
  (define (f k)
    (if (even? k)
        (/ (+ k 2) (+ k 1))
        (/ (+ k 1) (+ k 2))))
  (* 4.0 (product f 1 (lambda (x) (+ x 1)) n)))


;; b
(define (product-iter term a next b)
  (define (iter i product)
    (if (> i b)
        product
        (iter (next i) (* (term i) product)) ))
  (iter a 1))

(define (pi-iter n)
  (define (f k)
    (if (even? k)
        (/ (+ k 2) (+ k 1))
        (/ (+ k 1) (+ k 2))))
  (* 4.0 (product-iter f 1 (lambda (x) (+ x 1)) n)))
