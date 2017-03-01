(in-package :guests)

(defun asdf-base-path (name)
  (directory-namestring (asdf:component-pathname (asdf:find-system name))))

(defun guests-file (&optional  base)
  (concatenate 'string (asdf-base-path :guests) base))

(defmacro with-output-to-file ((filename &optional (if-exists :supersede)) &body body)
  `(with-open-file (*standard-output* ,filename :direction :output :if-exists ,if-exists
                                                :if-does-not-exist :create)
     ,@body))

(defun run-program-to-string (program args)
  (with-output-to-string (str)
    (asdf/run-program:run-program (format nil "~A ~{~A~^ ~}" program args) :output str)))

(defun mkstr (&rest args)
  (with-output-to-string (s)
    (dolist (a args) (when a (princ a s)))))

(defun symb (&rest args)
  (values (intern (apply #'mkstr args))))

(defun ksymb (&rest args)
  (values (intern (apply #'mkstr args) :keyword)))

(defvar *data-files* nil)

(defmacro defdataloader (name)
  (let ((var (symb '* name '*)))
    `(progn
       (defvar ,var nil)
       (pushnew ',name *data-files*)
       (defun ,(symb 'load- name) ()
           (let ((raw (read-from-string
                       (slurp-file (guests-file ,(format nil "data/~(~A~)-data.lisp" name))))))
             (setf ,var raw))))))

(defun load-data-files ()
  (iter (for name in *data-files*)
    (funcall (symb 'load- name))))
