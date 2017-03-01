(in-package :guests)

(defdataloader timeline)

(defun render-timeline (stream)
  (header-panel :main t :mode "seamed"
    (toolbar :class "time"
      (:span :style "margin-left:0px;" :id "wiki-title" :class "title" "Timeline")
      (icon-button :class "toolbar-icon" :style "margin-left:0px;" :icon "arrow-back" :onclick "page(\"/\");"))
    (:div :class "timeline" :id "timeline")))

(in-package :story-js)

(defun timeline-js ()
    (ps*
     `(progn
        (defvar *timeline-setup* nil)
        (defun setup-timeline ()
          (unless *timeline-setup*
            (setf *timeline-setup* t)
            (new ((@ vis *timeline)
                  (id "timeline")
                  (new ((@ vis *data-set)
                        (make-array
                         ,@(loop for el in guests::*timeline*
                                 for index from 1
                                 collect
                                 (destructuring-bind (y m d text) el
                                   `(create :id ,index :content ,text :start ,(format nil "~A-~A-~A" y m d))))))))))))))

(export 'timeline-js)

