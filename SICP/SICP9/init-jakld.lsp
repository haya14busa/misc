;(load "picture.lsp")
(start-picture)

;; Standard frame
(define frm1 (make-frame (make-vect 0.0 0.0)
                         (make-vect 1.0 0.0)
                         (make-vect 0.0 1.0)))

;; Shearing frame
(define frm2 (make-frame (make-vect 0.0 0.0)
                         (make-vect 0.66 0.33)
                         (make-vect 0.33 0.66)))

;; Compress to left
(define frm3 (make-frame (make-vect 0.0 0.0)
                         (make-vect 0.5 0.0)
                         (make-vect 0.0 1.0)))

;; Compress to bottom
(define frm4 (make-frame (make-vect 0.0 0.0)
                         (make-vect 1.0 0.0)
                         (make-vect 0.0 0.5)))

(define (show painter . frame)
  (clear-picture)
  (painter (if (null? frame) frm1 (car frame))))

(define (square x) (* x x))

