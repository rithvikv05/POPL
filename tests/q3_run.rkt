#lang racket/base

(define (inorder-list tree)
  (let ((build
         (let walk ((node tree)
                    (acc (lambda (tail) tail)))
           (if (null? node)
               acc
               (let ((left-acc (walk (cadr node) acc)))
                 (walk (caddr node)
                       (lambda (tail)
                         (left-acc (cons (car node) tail)))))))))
    (build '())))

(define (preorder-list tree)
  (let ((build
         (let walk ((node tree)
                    (acc (lambda (tail) tail)))
           (if (null? node)
               acc
               (let* ((with-node
                       (lambda (tail)
                         (acc (cons (car node) tail))))
                      (with-left
                       (walk (cadr node) with-node)))
                 (walk (caddr node) with-left))))))
    (build '())))

(define (postorder-list tree)
  (let ((build
         (let walk ((node tree)
                    (acc (lambda (tail) tail)))
           (if (null? node)
               acc
               (let* ((with-left (walk (cadr node) acc))
                      (with-right (walk (caddr node) with-left)))
                 (lambda (tail)
                   (with-right (cons (car node) tail))))))))
    (build '())))

(define (tree-height tree)
  (if (null? tree)
      0
      (+ 1 (max (tree-height (cadr tree))
                (tree-height (caddr tree))))))

(define (count-leaves tree)
  (if (null? tree)
      0
      (if (and (null? (cadr tree))
               (null? (caddr tree)))
          1
          (+ (count-leaves (cadr tree))
             (count-leaves (caddr tree))))))

(define (print-inorder tree)
  (display (inorder-list tree))
  (newline))

(define (print-all-traversals tree)
  (display (inorder-list tree))
  (newline)
  (display (preorder-list tree))
  (newline)
  (display (postorder-list tree))
  (newline))

(define (print-height-and-leaves tree)
  (display (list (tree-height tree)
                 (count-leaves tree)))
  (newline))

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

(run-q3-tests)
