(in-package :guests)

(defun asdf-base-path (name)
  (directory-namestring (asdf:component-pathname (asdf:find-system name))))

(defun guests-file (&optional  base)
  (concatenate 'string (asdf-base-path :guests) base))

(defmacro with-output-to-file ((filename &optional (if-exists :supersede)) &body body)
  `(with-open-file (*standard-output* ,filename :direction :output :if-exists ,if-exists
                                                :if-does-not-exist :create)
     ,@body))

(defvar *data-files* nil)

(defmacro defdataloader (name &key json)
  (let ((var (symb '* name '*))
        (json-var (symb '* name '-json*)))
    `(progn
       (defvar ,var nil)
       ,@(when json `((defvar ,json-var nil)))
       (pushnew ',name *data-files*)
       (defun ,(symb 'load- name) ()
         (let ((filename (guests-file ,(format nil "data/~(~A~)-data.lisp" name))))
           (setf ,var
                 (if (probe-file filename)
                     (read-from-string (slurp-file filename))
                     (warn "Missing data file ~S." filename)))
           ,@(when json `((setf ,json-var (json:encode-json-to-string ,var)))))
         (values))
       (defun ,(intern (format nil "~A-JSON" name) :story-js) () ,json-var))))

(defun load-data-files ()
  (iter (for name in *data-files*)
    (funcall (symb 'load- name))))

