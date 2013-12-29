(in-package :cl-user)
(defpackage hello-cave.config
  (:use :cl)
  (:import-from :envy
                :config-env-var
                :defconfig)
  (:export :config
           :*application-root*
           :*static-directory*
           :*template-directory*))
(in-package :hello-cave.config)

(setf (config-env-var) "APP_ENV")
(setf (osicat:environment-variable "APP_ENV") "debug")
(defparameter *application-root*   (asdf:system-source-directory :hello-cave))
(defparameter *static-directory*   (merge-pathnames #P"static/" *application-root*))
(defparameter *template-directory* (merge-pathnames #P"templates/" *application-root*))

(defconfig |debug|
    '(:databases
      ((:maindb :mysql :database-name "myapp" :username "root" :password "NEWPASSWORD")
       (:workerdb :mysql :database-name "jobs" :username "root" :password "NEWPASSWORD"))))

(defun config (&optional key)
  (envy:config #.(package-name *package*) key))
