(in-package #:rad-user)
(define-module #:bazaart
  (:use #:cl #:radiance #:r-clip)
  (:domain "bazaart.net"))
(in-package #:bazaart)

(define-route https :reversal (uri)
  (when (or (string-equal "bazaart.net" (domain *request*))
            (string-equal "www.bazaart.net" (domain *request*)))
    (setf (port uri) 443)))

(lquery:define-lquery-function page-template (node object)
  "Adds content from a different template."
  (setf (plump:children node) (plump:make-child-array))
  (plump:parse (template (format NIL "~(~a~).ctml" object)) :root node)
  node)

(define-page index #@"/" (:lquery (template "index.ctml"))
  "Main page."
  (r-clip:process T))

