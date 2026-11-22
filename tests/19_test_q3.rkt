#lang racket/base
;; Definitions only; use the temporary concatenation runner in run_tests.py.
;; Each fixture: name, tree, inorder, preorder, postorder, (height leaves).
(define q3-cases
  '((document-t1 (4 (2 (1 () ()) (3 () ())) (6 (5 () ()) (7 () ()))) (1 2 3 4 5 6 7) (4 2 1 3 6 5 7) (1 3 2 5 7 6 4) (3 4))
    (document-t2 (1 () (2 () (3 () ()))) (1 2 3) (1 2 3) (3 2 1) (3 1))
    (document-t3 (a (b () ()) (c () ())) (b a c) (a b c) (b c a) (2 2))
    (document-empty () () () () (0 0))
    (custom-single-number (42 () ()) (42) (42) (42) (1 1))
    (custom-single-symbol (z () ()) (z) (z) (z) (1 1))
    (custom-left-chain (3 (2 (1 () ()) ()) ()) (1 2 3) (3 2 1) (1 2 3) (3 1))
    (custom-asymmetric (4 (2 () (3 () ())) (7 (5 () ()) ())) (2 3 4 5 7) (4 2 3 7 5) (3 2 5 7 4) (3 2))
    (custom-duplicate-values (1 (1 () ()) (1 () ())) (1 1 1) (1 1 1) (1 1 1) (2 2))
    (custom-zero-negative (-1 (-2 () ()) (0 () ())) (-2 -1 0) (-1 -2 0) (-2 0 -1) (2 2))))

;; Structural comparison for the small exact integers and symbols in the fixtures.
(define (same? a b)
  (cond ((null? a) (null? b))
        ((pair? a) (and (pair? b) (same? (car a) (car b)) (same? (cdr a) (cdr b))))
        ((or (null? b) (pair? b)) #f)
        (else (eq? a b))))

(define (check name actual expected)
  (display name)
  (if (same? actual expected)
      (begin (display '=>PASS) (newline) #t)
      (begin (display '=>FAIL) (newline) #f)))


(define (run-q3-tests)
  (let loop ((cases q3-cases) (passed #t))
    (if (null? cases)
        (begin
          (display (if passed 'ALL-TESTS-PASSED 'SOME-TESTS-FAILED))
          (newline))
        (let* ((item (car cases))
               (tree (cadr item))
               (expected (cddr item))
               (ok (check (car item)
                          (list (inorder-list tree)
                                (preorder-list tree)
                                (postorder-list tree)
                                (list (tree-height tree) (count-leaves tree)))
                          expected)))
          (loop (cdr cases) (and passed ok))))))

;; Exercise every public print function on every fixture.
;; The Python runner compares the complete stdout byte-for-byte.
(define (run-q3-output-tests)
  (let loop ((cases q3-cases))
    (if (null? cases)
        (begin (display 'OUTPUT-END) (newline))
        (let ((item (car cases)))
          (display (car item)) (newline)
          (print-inorder (cadr item))
          (print-all-traversals (cadr item))
          (print-height-and-leaves (cadr item))
          (loop (cdr cases))))))

(define (print-q3-expected-output)
  (let loop ((cases q3-cases))
    (if (null? cases)
        (begin (display 'OUTPUT-END) (newline))
        (let* ((item (car cases)) (expected (cddr item)))
          (display (car item)) (newline)
          (display (car expected)) (newline)
          (display (car expected)) (newline)
          (display (cadr expected)) (newline)
          (display (caddr expected)) (newline)
          (display (cadddr expected)) (newline)
          (loop (cdr cases))))))
