(in-package :cl-user)
(defpackage hello-cave-asd
  (:use :cl :asdf))
(in-package :hello-cave-asd)

(defsystem hello-cave
  :version "0.1"
  :author "John Walker"
  :license ""
  :depends-on (:clack
               :caveman2
               :envy
               :osicat
               :cl-ppcre
	       :cl-who

               ;; HTML Template
               :cl-emb
	       
               ;; for rendering JSON
               :yason
               :trivial-types

               ;; for CL-DBI
               :caveman2-db)
  :components ((:module "src"
                :components
                ((:file "hello-cave" :depends-on ("config"))
                 (:file "web" :depends-on ("view"))
                 (:file "view" :depends-on ("config"))
                 (:file "config"))))
  :description ""
  :in-order-to ((test-op (load-op hello-cave-test))))
