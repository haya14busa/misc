(define nil '())

;; equal?
(define (equal? items1 items2)
  (cond ((eq? items1 items2) #t)
        ((not (pair? items1)) (eq? items1 items2))
        ((not (pair? items2)) #f)
        ((equal? (car items1) (car items2))
         (equel? (cdr items1) (cdr items2)) )))
;; list-ref
(display "(define (list-ref items n)")
(define (list-ref items n)
  (if (= n 0)
      (car items)
      (list-ref (cdr items) (- n 1))))
;; Length
(define (length items)
  (if (null? items)
      0
      (+ 1 (length (cdr items)))))
(define (length-i items)
  (define (iter count data)
    (if (null? data)
        count
        (iter (+ 1 count) (cdr data)) ))
  (iter items 0))
;; Copy
(define (copy items)
  (cond ((null? items) items)
        ((not (pair? items)) items)
        (else (cons (car items)
                    (copy (cdr items)) ))))
;; deep-copy
(define (deep-copy items)
  (cond ((null? items) items)
        ((not (pair? items)) items)
        (else (cons (deep-copy (car items))
                    (deep-copy (cdr items))))))
;; Append
(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1)
            (append (cdr list1)
                    list2)
            )))
;; Reverse
;; swap can be implemented by reverse algorithim
(define (reverse items)
  (if (null? items)
      nil
      (append
        (reverse (cdr items))
        (list (car items)) )))

;; Member
(define (member x items)
  (cond ((null? items) nil)
        ((equal? x (car items)) items)
        (else (member x (cdr items))) ))
(define (memq x items)
  (cond ((null? items) nil)
        ((eq? x (car items)) items)
        (else (memq x (cdr items))) ))
;; Assoc
(define (assoc x alist)
  (cond ((null? alist) nil)
        ((and (pair? (car alist))
              (equal? x (car alist)) )
         (car alist) )
        (else (assoc x (cdr items))) ))
;; Each item in list
(define (absolute-list items)
  (if (null? items)
      nil
      (cons (abs (car items))
            (absolute-list (cdr items)) )))
(define (scale-list items factor)
  (if (null? items)
      nil
      (cons (* (car items) factor)
            (scale-list (cdr items)
                        factor ))))
(define (map proc items)
  (if (null? items)
      nil
      (cons (proc (car items))
            (map proc (cdr items)) )))
(display (map abs (list -10 2.5 -11.6 17)))

;; Arguments with dotted-tail notation
(define (sum . items)
       (define (iter items result)
         (if (null? items)
             result
             (iter (cdr items)
                   (+ result (car items))
            )))
       (iter items 0) )
(newline)
(display (sum 1 2 3 4 5))


