#lang racket/base

(define (my-length lst)
  (let loop ((remaining lst) (count 0))
    (if (null? remaining)
        count
        (loop (cdr remaining) (+ count 1)))))

(define (my-reverse lst)
  (let loop ((remaining lst) (result '()))
    (if (null? remaining)
        result
        (loop (cdr remaining) (cons (car remaining) result)))))

(define (my-map f lst)
  (let loop ((remaining lst) (result '()))
    (if (null? remaining)
        (my-reverse result)
        (loop (cdr remaining)
              (cons (f (car remaining)) result)))))

(define (insert-if-short x lst n)
  (let ((original-length (my-length lst)))
    (let ((processed
           (my-map (lambda (element)
                     (if (or (null? element) (pair? element))
                         (insert-if-short x element n)
                         element))
                   lst)))
      (if (< original-length n)
          (cons x processed)
          processed))))

(define (print-insert-result)
  (let* ((x (read))
         (lst (read))
         (n (read)))
    (display (insert-if-short x lst n))
    (newline)))

(define (make-inserter x len-ok?)
  (letrec ((insert
            (lambda (lst)
              (let ((original-length (my-length lst)))
                (let ((processed
                       (my-map (lambda (element)
                                 (if (or (null? element) (pair? element))
                                     (insert element)
                                     element))
                               lst)))
                  (if (len-ok? original-length)
                      (cons x processed)
                      processed))))))
    insert))

(define (insert-if-short x lst n)
  ((make-inserter x (lambda (len) (< len n))) lst))

