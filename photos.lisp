(in-package :guests)

(defparameter *photo-directory* (guests-file "photos/"))

(defvar *photos* nil)
(pushnew 'photos *data-files*)

(defun load-photos (&key set-comments clean)
  (setf *photos*
        (iter (for file in (directory-files (guests-file "photos/")))
          (when clean (clean-image file))
          (collect (list (format nil "~A.~A" (pathname-name file) (pathname-type file))
                         (or (image-comment file)
                             (and set-comments
                                  (progn
                                    (format t "comment for ~S: " (pathname-name file))
                                    (force-output)
                                    (set-image-comment file (read-line))))))))))

(defun render-photos (stream)
  (header-panel :mode "seamed"
    (toolbar :class "time"
      (:span :style "margin-left:0px;" :class "title" "Photos")
      (icon-button :class "toolbar-icon" :style "margin-left:0px;" :icon "arrow-back" :onclick "page(\"/\");"))
    (:div :class "photos"
          (iter (for (name desc) in *photos*)
            (for index from 1)
            (card
              (:div :class "card-content photo" :style "max-width:500px;"
                    (image :src (format nil "photos/~A" name))
                    (:div :class "attr"
                          (:div :class "desc" (esc desc)))))))))

(defun create-image-thumbnail (name &optional (width 200) (height 200))

  )
