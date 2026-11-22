#lang racket/base

;; Append this file below id_q3.rkt after removing this #lang line.

(define t1 '(4 (2 (1 () ()) (3 () ())) (6 (5 () ()) (7 () ()))))
(define t2 '(1 () (2 () (3 () ()))))
(define t3 '(a (b () ()) (c () ())))
(define empty-tree '())
(define single-node '(42 () ()))

;; Expected: (1 2 3 4 5 6 7), (1 2 3 4 5 6 7),
;;           (4 2 1 3 6 5 7), (1 3 2 5 7 6 4), (3 4).
(display 't1)
(newline)
(print-inorder t1)
(print-all-traversals t1)
(print-height-and-leaves t1)

;; Expected: (1 2 3), (1 2 3), (1 2 3), (3 2 1), (3 1).
(display 't2)
(newline)
(print-inorder t2)
(print-all-traversals t2)
(print-height-and-leaves t2)

;; Expected: (b a c), (b a c), (a b c), (b c a), (2 2).
(display 't3)
(newline)
(print-inorder t3)
(print-all-traversals t3)
(print-height-and-leaves t3)

;; Expected: (), (), (), (), (0 0).
(display 'empty-tree)
(newline)
(print-inorder empty-tree)
(print-all-traversals empty-tree)
(print-height-and-leaves empty-tree)

;; Expected: (42), (42), (42), (42), (1 1).
(display 'single-node)
(newline)
(print-inorder single-node)
(print-all-traversals single-node)
(print-height-and-leaves single-node)
