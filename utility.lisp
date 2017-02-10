(in-package :guests)

(defun asdf-base-path (name)
  (directory-namestring (asdf:component-pathname (asdf:find-system name))))

(defun guests-file (&optional  base)
  (concatenate 'string (asdf-base-path :guests) base))

(defmacro with-output-to-file ((filename &optional (if-exists :supersede)) &body body)
  `(with-open-file (*standard-output* ,filename :direction :output :if-exists ,if-exists
                                                :if-does-not-exist :create)
     ,@body))
