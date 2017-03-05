(in-package :guests)

(defun parse-signs-file (&optional (filename (guests-file "raw-signs.html")))
  (iter (for el in (fourth (chtml:parse (slurp-file filename) (chtml:make-lhtml-builder))))
    (when (consp el)
      (let ((raw-name (string-right-trim '(#\space #\.) (third (third (third el))))))
        (let ((name (if-let (hit (ppcre:scan "or" raw-name))
                      (list (string-downcase (subseq raw-name 0 (1- hit)))
                            (string-downcase (subseq raw-name (+ 3 hit))))
                      (string-downcase raw-name))))
          (collect
              (list name
                    ()
                    (if (= (length el) 4)
                        (substitute #\space #\newline (string-left-trim '(#\space) (fourth el)))
                        (iter (for p in (cdddr el))
                          (unless (consp p) (collect (string-left-trim '(#\space) p))))))))))))


(defun save-signs-file ()
  (with-output-to-file ((guests-file "signs-data.lisp"))
    (prin1 (parse-signs-file))))

(defun run-program-to-string (program args)
  (with-output-to-string (str)
    (asdf/run-program:run-program (format nil "~A ~{~A~^ ~}" program args) :output str)))

(defun extract-pdf-page (page)
  (asdf/run-program:run-program (format nil "pdfimages -png -f ~A -l ~A ~A ~A" page page (guests-file "docs/indian-signs.pdf") (guests-file (format nil "generated/signs-~A" page)))))

(defun split-signs-image (page &optional (width 960) (height 900) (dx 348) (dy 432))
  (ensure-directories-exist (guests-file "generated/"))
  (extract-pdf-page page)
  (iter (for row from 0 to 4)
    (iter (for col from 0 to 2)
      (asdf/run-program:run-program
       (format nil "convert ~A -crop ~Ax~A+~A+~A ~A"
               (guests-file "generated/signs-000.png")
               width height
               (+ dx (* col width)) (+ dy (* row height))
               (guests-file (format nil "generated/sign-~A-~A-~A.png" page row col))
               )))))

