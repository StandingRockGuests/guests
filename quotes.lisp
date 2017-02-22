(in-package :guests)

(defvar *quotes* nil)

(defun load-quotes ()
  (let ((raw (read-from-string (slurp-file (guests-file "quotes-data.lisp")))))
    (setf *quotes* raw)))

(defun render-quotes (stream)
  (header-panel :mode "seamed"
    (toolbar :class "time"
      (:span :style "margin-left:0px;" :class "title" "Quotes")
      (icon-button :class "toolbar-icon" :style "margin-left:0px;" :icon "arrow-back" :onclick "page(\"/\");"))
    (:div :class "quotes"
          (iter (for (text name desc) in *quotes*)
            (for index from 1)
            (card
              (:div :class "card-content quote" :style "max-width:500px;"
                    (:div :class "text" "“" (esc text) "”")
                    (:div :class "attr"
                     (:div :class "name" "— " (esc name))
                     (:div :class "desc" (esc desc)))))))))

