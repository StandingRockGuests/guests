(in-package :guests)

(defdataloader timeline)

(defun render-timeline (stream)
  (header-panel :main t :mode "seamed"
    (toolbar :class "time"
      (:span :style "margin-left:0px;" :id "wiki-title" :class "title" "Timeline")
      (icon-button :class "toolbar-icon" :style "margin-left:0px;" :icon "arrow-back" :onclick "page(\"/\");"))
    (:div :class "timeline" :id "timeline")))

(defun render-timeline-entry (y text)
  (with-output-to-string (stream)
    (card
      (:div :class "te card-content"
            (esc text)))))

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
                                 (destructuring-bind (y text) el
                                   `(create :id ,index
                                            :content ,(guests::render-timeline-entry y text)
                                            :start ,(format nil "~A" (if (consp y) (first y) y))
                                            ,@(when (consp y)
                                                `(:end ,(format nil "~A" (second y))))
                                            ))))))
                  (create :start "1492" :end "2020" :width "100%")
                  )))))))

(export 'timeline-js)

