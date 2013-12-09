;(load "picture.lsp")
;(start-picture)

; (define rogers (image->painter "rogers.gif"))
;(define orida (image->painter "d:/java/scheme/orida-sensei.gif"))

;; The following code for wave was borrowed from
;; http://oss.timedia.co.jp/index.cgi/kahua-web/show/SICP/ex-2.49

(define wave
  (let ((p01 (make-vect 0.40 1.00))
        (p02 (make-vect 0.60 1.00))
        (p03 (make-vect 0.00 0.80))
        (p04 (make-vect 0.35 0.80))
        (p05 (make-vect 0.65 0.80))
        (p06 (make-vect 0.00 0.60))
        (p07 (make-vect 0.30 0.60))
        (p08 (make-vect 0.40 0.60))
        (p09 (make-vect 0.60 0.60))
        (p10 (make-vect 0.70 0.60))
        (p11 (make-vect 0.20 0.55))
        (p12 (make-vect 0.30 0.55))
        (p13 (make-vect 0.35 0.50))
        (p14 (make-vect 0.65 0.50))
        (p15 (make-vect 0.20 0.45))
        (p16 (make-vect 1.00 0.40))
        (p17 (make-vect 0.50 0.20))
        (p18 (make-vect 1.00 0.20))
        (p19 (make-vect 0.25 0.00))
        (p20 (make-vect 0.40 0.00))
        (p21 (make-vect 0.60 0.00))
        (p22 (make-vect 0.75 0.00)))
    (segments->painter
      (list (make-segment p01 p04)
            (make-segment p04 p08)
            (make-segment p08 p07)
            (make-segment p07 p11)
            (make-segment p11 p03)
            (make-segment p06 p15)
            (make-segment p15 p12)
            (make-segment p12 p13)
            (make-segment p13 p19)
            (make-segment p20 p17)
            (make-segment p17 p21)
            (make-segment p22 p14)
            (make-segment p14 p18)
            (make-segment p16 p10)
            (make-segment p10 p09)
            (make-segment p09 p05)
            (make-segment p05 p02)))))

(define letterlambda
  (vertexes->painter
    (list (make-vect .45 .6)
          (make-vect .25 .2)
          (make-vect .2 .2)
          (make-vect .2 .1)
          (make-vect .3 .1)
          (make-vect .5 .5)
          (make-vect .7 .1)
          (make-vect .8 .1)
          (make-vect .8 .2)
          (make-vect .75 .2)
          (make-vect .4 .9)
          (make-vect .3 .9)
          (make-vect .3 .8)
          (make-vect .35 .8))
    #t ;; fill inside the polygon?
    ))

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

;; Figure 2.9

; (show (square-limit wave 4))
; (show (square-limit rogers 4))

;; Figure 2.10

; (show wave)
; (show wave frm2)
; (show wave frm3)
; (show wave frm4)

;; Figure 2.11

; (show rogers)
; (show rogers frm2)
; (show rogers frm3)
; (show rogers frm4)

;; Figure 2.12

; (define wave2 (beside wave (flip-vert wave)))
; (show wave2)
; (define wave4 (below wave2 wave2))
; (show wave4)

;; Figure 2.14

; (show (right-split wave 4))
; (show (right-split rogers 4))
; (show (corner-split wave 4))
; (show (corner-split rogers 4))

; (show letterlambda)
; (show letterlambda frm2)
; (show letterlambda frm3)
; (show letterlambda frm4)
; (show (right-split letterlambda 4))
; (show (corner-split letterlambda 4))
