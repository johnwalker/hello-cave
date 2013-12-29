(in-package :cl-user)
(defpackage hello-cave.web
  (:use :cl
        :caveman2
        :caveman2.db
        :hello-cave.config
        :hello-cave.view
	:cl-who)
  (:export :*web*))
(in-package :hello-cave.web)

;; Application

(defclass <web> (<app>) ())
(defparameter *web* (make-instance '<web>))

;;
;; Routing rules

(defroute "/" ()
  (with-layout (:title "Welcome to Caveman2")
    (render #P"index.tmpl")))

(defvar output)

(defroute "/register/:username/:password" (&key username password)
  (let ((db (connect-db :maindb)))
    (insert-into db :user
      (set= :username username
	    :password password)))
  "Registration successful!")

(defroute "/users" ()
  (let ((results (select-all (connect-db :maindb) :* (from :user))))
    (render #P"users.tmpl"
	    (list :users results))))

;; Error pages

(defmethod on-exception ((app <web>) (code (eql 404)))
  (declare (ignore app))
  (merge-pathnames #P"_errors/404.html"
                   *template-directory*))
