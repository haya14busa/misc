(define nil '())
;; Count-leaver
(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))
              ))))
;; Max-height
(define (max-height x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else
          (+ 1 (max (max-height (car x))
                    (max-height (cdr x))
                    )))))
;; scale-tree
(define (scale-tree tree factor)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (* tree factor))
        (else
          (cons (scale-tree (car tree) factor)
                (scale-tree (car tree) factor)
                ))))
(define (scale-tree-map tree factor)
  (map
    (lambda (sub-tree)
      (if (pair? sub-tree)
          (scale-tree-map sub-tree factor)
          (* sub-tree factor) ))
    tree ))
;; powerset
(define (powerset a)
  (if (null? a)
    (list nil)
    (let ((rest (powerset (cdr a)))
          (append
            rest
            (map
              (lambda (x)
                (append (list (car a)) x))
              rest ))))))
