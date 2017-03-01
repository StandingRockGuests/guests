(in-package :guests)

(defun parse-timeline-file (&optional (filename (guests-file "timelines/usdakotawar_org.html")))
  (labels ((trim (string)
             (substitute #\space #\no-break_space
                         (string-trim '(#\newline #\space #\no-break_space #\tab) string)) )
           (parse-date (string)
             (destructuring-bind (from . to) (split-sequence #\- string)
               (story::bugout from to)
               (cond
                    (to (list (chronicity:parse (trim from)) (chronicity:parse (trim (car to)))))
                    (t (chronicity:parse from)))))
           (split-date (string)
             (destructuring-bind (text . date) (split-sequence #\: string)
               (let ((date (and date (parse-date (trim (car date))))))
                 (list text date)))))
    (let (acc p)
      (iter (for el in (cddr (fourth (chtml:parse (slurp-file filename) (chtml:make-lhtml-builder)))))
        (cond
          ((stringp el))
          ((consp (third el))
           (when p (push (nreverse p) acc))
           (setf p (cons (trim (fourth el))
                         (split-date (trim (third (third el)))))))
          (t (push (trim (third el)) p)))
        (finally (push (trim el) p) (push (nreverse p) acc)))
      (nreverse acc))))


(defun save-timeline-file ()
  (with-output-to-file ((guests-file "data/timeline-data.lisp"))
    (prin1 (parse-timeline-file))))
