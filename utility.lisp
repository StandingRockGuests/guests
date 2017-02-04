(in-package :guests)

(defun asdf-base-path (name)
  (directory-namestring (asdf:component-pathname (asdf:find-system name))))

(defun guests-file (&optional  base)
  (concatenate 'string (asdf-base-path :guests) base))
