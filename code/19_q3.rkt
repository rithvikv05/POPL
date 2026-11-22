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
                   (with-right (cons (car node) tail)))))))
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