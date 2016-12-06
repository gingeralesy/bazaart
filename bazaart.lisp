(in-package #:rad-user)
(define-module #:bazaart
  (:use #:cl #:radiance #:r-clip)
  (:domain "bazaart"))
(in-package #:bazaart)

;; -- move the parameter and routes below to the startup script as these are
;;    server specific configurations
(defparameter *outside-domain* "bazaart.net")

(define-route default (:mapping -100) (uri)
  (unless (module-p (first (domains uri)))
    (push "bazaart" (domains uri))))

(define-route default (:reversal -100) (uri)
  (when (string= "bazaart" (first (domains uri)))
    (pop (domains uri))))

(define-route https (:reversal -200) (uri)
  (let ((req-domain (domain *request*))
        (out-domain *outside-domain*))
    (when (string= out-domain req-domain
                   :start2 (max 0 (- (length req-domain) (length out-domain))))
      (setf (port uri) 443))))
;; keep the stuff from here on --

(lquery:define-lquery-function page-template (node object)
  "Adds content from a different template."
  (setf (plump:children node) (plump:make-child-array))
  (plump:parse (template (format NIL "~(~a~).ctml" object)) :root node)
  node)

(define-page index "bazaart/$" (:lquery (template "index.ctml"))
  (r-clip:process T))

(define-page search "bazaart/search" (:lquery (template "search.ctml"))
  (r-clip:process T :query (get-var "query") :results NIL))
