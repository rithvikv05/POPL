#lang racket/base

;; Structural comparison for the numbers and symbols used in these tests.
(define (same? a b)
  (cond ((null? a) (null? b))
        ((pair? a)
         (and (pair? b)
              (same? (car a) (car b))
              (same? (cdr a) (cdr b))))
        (else (eq? a b))))

;; Print one result and return #t on success, #f on failure.
(define (check name actual expected)
  (display name)
  (display '=>)
  (if (same? actual expected)
      (begin
        (display 'PASS)
        (newline)
        #t)
      (begin
        (display 'FAIL)
        (newline)
        #f)))

(define (make-deep-input)
  (let loop ((remaining 100) (value '()))
    (if (= remaining 0)
        value
        (loop (- remaining 1) (list value)))))

(define (make-deep-expected)
  (let loop ((remaining 100) (value '(z)))
    (if (= remaining 0)
        value
        (loop (- remaining 1) (list 'z value)))))

(define (make-flat-input)
  (let loop ((remaining 10000) (value '()))
    (if (= remaining 0)
        value
        (loop (- remaining 1) (cons 'a value)))))

;; Call this explicitly from a temporary runner; loading this file prints nothing.
(define (run-q4-tests)
  (let* ((t1
          (check 'example-1
                 (insert-if-short 42 '((1 2) (3 4 5) (6) ()) 3)
                 '((42 1 2) (3 4 5) (42 6) (42))))
         (t2
          (check 'example-2
                 (insert-if-short 0 '(((1) 2) (3) ((4 5 6) ())) 3)
                 '((0 (0 1) 2) (0 3) (0 (4 5 6) (0)))))
         (t3
          (check 'empty-list-inserts-when-threshold-positive
                 (insert-if-short 7 '() 3)
                 '(7)))
         (t4
          (check 'empty-list-does-not-insert-at-threshold-zero
                 (insert-if-short 7 '() 0)
                 '()))
         (t5
          (check 'length-equal-to-threshold-does-not-insert
                 (insert-if-short 'z '(a b c) 3)
                 '(a b c)))
         (insert-length-two
          (make-inserter 'z (lambda (k) (= k 2))))
         (t6
          (check 'custom-predicate
                 (insert-length-two '((a) (b c) () d))
                 '((a) (z b c) () d)))
         (t7
          (check 'custom-top-level
                 (insert-length-two '(a (b c)))
                 '(z a (z b c))))
         (t8
          (check 'depth-100
                 (insert-if-short 'z (make-deep-input) 2)
                 (make-deep-expected)))
         (t9
          (check 'flat-10000
                 (insert-if-short 'z (make-flat-input) 10001)
                 (cons 'z (make-flat-input)))))
    (if (and t1 t2 t3 t4 t5 t6 t7 t8 t9)
        (begin
          (display 'ALL-TESTS-PASSED)
          (newline))
        (begin
          (display 'SOME-TESTS-FAILED)
          (newline)))))

;; Optional input/output smoke test. Invoke explicitly after loading the
;; implementation and this test file, then provide x, lst, n on standard input.
(define (run-q4-input-tests)
  (begin
    (print-insert-result)
    (print-insert-result)
    (print-insert-result)
    (print-insert-result)))
