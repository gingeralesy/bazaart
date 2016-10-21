(in-package #:cl-user)
(asdf:defsystem #:bazaart
  :defsystem-depends-on (:radiance :r-clip)
  :class "radiance:module"
  :components ((:file "bazaart"))
  :depends-on (:lass))
