(define (quicksort lst)
  (if (null? lst)
      `()

(define (join lst1 lst2)
  (if (null? lst1)
      lst2
      (cons (car lst1) (join (cdr lst1) lst2))))


