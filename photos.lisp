(in-package :guests)

(defparameter *photo-directory* (guests-file "photos/"))

(defun render-photos (stream)
  (header-panel :mode "seamed"
    (toolbar :class "time"
      (:span :style "margin-left:0px;" :class "title" "Photos")
      (icon-button :class "toolbar-icon" :style "margin-left:0px;"
        :icon "arrow-back" :onclick "page(\"/\");"))
    (:div :id "photos")))

(defun create-photos-file-listing ()
  (save-file-listing (guests-file "photos/")))

(in-package :story-js)

(define-script photos
  (defun show-photos ()
    (select-page 7)
    (render-image-gallery "photos" "/photos/")

))

