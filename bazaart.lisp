(in-package #:rad-user)
(define-module #:bazaart
  (:use #:cl #:radiance #:r-clip)
  (:domain "bazaart"))
(in-package #:bazaart)

(lquery:define-lquery-function page-template (node object)
  "Adds content from a different template."
  (setf (plump:children node) (plump:make-child-array))
  (plump:parse (template (format NIL "~(~a~).ctml" object)) :root node)
  node)

(define-page index #@"/" (:lquery (template "index.ctml"))
  "Main page."
  (r-clip:process T))

