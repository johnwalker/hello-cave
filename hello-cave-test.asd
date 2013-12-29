(in-package :cl-user)
(defpackage hello-cave-test-asd
  (:use :cl :asdf))
(in-package :hello-cave-test-asd)

(defsystem hello-cave-test
  :author "John Walker"
  :license ""
  :depends-on (:hello-cave
               :cl-test-more)
  :components ((:module "t"
                :components
                ((:file "hello-cave"))))
  :perform (load-op :after (op c) (asdf:clear-system c)))
