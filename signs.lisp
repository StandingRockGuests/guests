(in-package :guests)

(defparameter *signs-directory* (guests-file "signs/"))

(defdataloader signs)

(defun render-signs (stream)
  (header-panel :mode "seamed"
    (toolbar :class "time"
      (:span :style "margin-left:0px;" :class "title" "Sign Language")
      (icon-button :class "toolbar-icon" :style "margin-left:0px;" :icon "arrow-back" :onclick "page(\"/\");"))
    (:div
     :id "signs"
     (iter (for el in *signs*)
       (for index from 1 to 100)
       (destructuring-bind (name image pos text)
           (if (= (length el) 2)
               (list (first el) nil nil (second el))
               el)
         (card :class "sign"
           (:div :class "card-content"
                 :onclick (ps* `(toggle-sign ,index))
                 (if image
                   (destructuring-bind (x y w h) pos
                     (htm (:div
                           :style (format nil "width:~Apx;height:~Apx;" w h)
                           (:img
                            :style (format nil "position:absolute;clip:rect(~Apx,~Apx,~Apx,~Apx);margin-left:-~Apx;margin-top:-~Apx" y (+ x w) (+ y h) x x y)
                            :src (format nil "/signs/s~A.png" image)))))
                   (str (if (consp name) (format nil "~{~A~^/~}" name) name)))
                 (collapse :id (format nil "sn-~A" index)
                   (:div :class "sn"
                         (if (stringp text) (esc text)
                             (esc (car text))))))))))))

(in-package :story-js)

(define-script signs
  (defun toggle-sign (index)
    (let ((el (id (+ "sn-" index)))))
    ((@ el toggle))))

                                        ; (defun parse-signs-file (&optional (filename (guests-file "raw-signs.html")))
;;   (iter (for el in (fourth (chtml:parse (slurp-file filename) (chtml:make-lhtml-builder))))
;;     (when (consp el)
;;       (let ((raw-name (string-right-trim '(#\space #\.) (third (third (third el))))))
;;         (let ((name (if-let (hit (ppcre:scan "or" raw-name))
;;                       (list (string-downcase (subseq raw-name 0 (1- hit)))
;;                             (string-downcase (subseq raw-name (+ 3 hit))))
;;                       (string-downcase raw-name))))
;;           (collect
;;               (list name
;;                (if (= (length el) 4)
;;                    (substitute #\space #\newline (string-left-trim '(#\space) (fourth el)))
;;                    (iter (for p in (cdddr el))
;;                      (unless (consp p) (collect (string-left-trim '(#\space) p))))))))))))


;; (defun save-signs-file ()
;;   (with-output-to-file ((guests-file "signs-data.lisp"))
;;     (prin1 (parse-signs-file))))
