(in-package :cl-user)
(defpackage hello-cave
  (:use :cl)
  (:import-from :hello-cave.config
                :config)
  (:import-from :clack
                :clackup)
  (:export :start
           :stop))
(in-package :hello-cave)

(defvar *appfile-path*
  (asdf:system-relative-pathname :hello-cave #P"app.lisp"))

(let (handler)
  (defun start (&rest args &key server port debug &allow-other-keys)
    (when handler
      (error "Server is already started."))
    (setf handler
          (apply #'clackup *appfile-path* args)))

  (defun stop ()
    (prog1
     (clack:stop handler)
     (setf handler nil))))
