;; Initialize
(load "init-jakld.lsp")

;; 1. square-limit
(load "wave-jakld.lsp")
((square-limit wave 4) frm1)
(save-picture "wave.jpg")

(clear-picture)

;; 2. Colored letterlambda

;; define filled-letterlambda
(define filled-letterlambda
  (vertexes->painter
    (list
      (make-vect .45 .60) (make-vect .25 .20)
      (make-vect .25 .20) (make-vect .20 .20)
      (make-vect .20 .20) (make-vect .20 .10)
      (make-vect .20 .10) (make-vect .30 .10)
      (make-vect .30 .10) (make-vect .50 .50)
      (make-vect .50 .50) (make-vect .70 .10)
      (make-vect .70 .10) (make-vect .80 .10)
      (make-vect .80 .10) (make-vect .80 .20)
      (make-vect .80 .20) (make-vect .75 .20)
      (make-vect .75 .20) (make-vect .40 .90)
      (make-vect .40 .90) (make-vect .30 .90)
      (make-vect .30 .90) (make-vect .30 .80)
      (make-vect .30 .80) (make-vect .35 .80)
      (make-vect .35 .80) (make-vect .45 .60) )
    #t ))

;; change color
(set-color 'cyan)
(filled-letterlambda frm1)
(save-picture "colored_letterlambda.jpg")

(clear-picture)

;; 3. apply square-limit
((square-limit filled-letterlambda 4) frm1)
(save-picture "square-limit_lambda.jpg")
