#lang racket/base

;; Run by appending this file's definitions and calls (excluding its #lang line)
;; to a temporary copy of id_q4.rkt; id_q4.rkt exports no definitions.

(define (same? a b)
  (cond ((null? a) (null? b))
        ((pair? a)
         (and (pair? b)
              (same? (car a) (car b))
              (same? (cdr a) (cdr b))))
        (else (eq? a b))))

(define (check name actual expected)
  (display name)
  (display '=>)
  (display (same? actual expected))
  (newline))

(check 'example-1
       (insert-if-short 42 '((1 2) (3 4 5) (6) ()) 3)
       '((42 1 2) (3 4 5) (42 6) (42)))

(check 'example-2
       (insert-if-short 0 '(((1) 2) (3) ((4 5 6) ())) 3)
       '((0 (0 1) 2) (0 3) (0 (4 5 6) (0))))

(check 'example-3 (insert-if-short 7 '() 3) '(7))
(check 'example-4 (insert-if-short 7 '() 0) '())

(define insert-length-two
  (make-inserter 'z (lambda (k) (= k 2))))

(check 'custom-predicate
       (insert-length-two '((a) (b c) () d))
       '((a) (z b c) () d))

(check 'custom-top-level
       (insert-length-two '(a (b c)))
       '(z a (z b c)))

(define deep-input
  (let loop ((remaining 100) (value '()))
    (if (= remaining 0)
        value
        (loop (- remaining 1) (list value)))))

(define deep-expected
  (let loop ((remaining 100) (value '(z)))
    (if (= remaining 0)
        value
        (loop (- remaining 1) (list 'z value)))))

(check 'depth-100
       (insert-if-short 'z deep-input 2)
       deep-expected)

(define flat-input
  (let loop ((remaining 10000) (value '()))
    (if (= remaining 0)
        value
        (loop (- remaining 1) (cons 'a value)))))

(check 'flat-10000
       (insert-if-short 'z flat-input 10001)
       (cons 'z flat-input))

;; The four lines below print the four specification outputs in order.
;; Feed x, lst, n for each call via standard input.
(print-insert-result)
(print-insert-result)
(print-insert-result)
(print-insert-result)
