#lang racket/base

;; Test data for Q3.
;; This file contains definitions only. It is combined with code/19_q3.rkt
;; by the PowerShell commands provided with the review.

(define t1 '(4 (2 (1 () ()) (3 () ())) (6 (5 () ()) (7 () ()))))
(define t2 '(1 () (2 () (3 () ()))))
(define t3 '(a (b () ()) (c () ())))
(define empty-tree '())
(define single-node '(42 () ()))

(define (run-q3-tests)
  ;; t1 expected:
  ;; inorder  (1 2 3 4 5 6 7)
  ;; preorder (4 2 1 3 6 5 7)
  ;; postorder (1 3 2 5 7 6 4)
  ;; height/leaves (3 4)
  (display 't1)
  (newline)
  (print-inorder t1)
  (print-all-traversals t1)
  (print-height-and-leaves t1)

  ;; t2 expected:
  ;; inorder  (1 2 3)
  ;; preorder (1 2 3)
  ;; postorder (3 2 1)
  ;; height/leaves (3 1)
  (display 't2)
  (newline)
  (print-inorder t2)
  (print-all-traversals t2)
  (print-height-and-leaves t2)

  ;; t3 expected:
  ;; inorder  (b a c)
  ;; preorder (a b c)
  ;; postorder (b c a)
  ;; height/leaves (2 2)
  (display 't3)
  (newline)
  (print-inorder t3)
  (print-all-traversals t3)
  (print-height-and-leaves t3)

  ;; empty-tree expected:
  ;; all traversals (), height/leaves (0 0)
  (display 'empty-tree)
  (newline)
  (print-inorder empty-tree)
  (print-all-traversals empty-tree)
  (print-height-and-leaves empty-tree)

  ;; single-node expected:
  ;; all traversals (42), height/leaves (1 1)
  (display 'single-node)
  (newline)
  (print-inorder single-node)
  (print-all-traversals single-node)
  (print-height-and-leaves single-node))
