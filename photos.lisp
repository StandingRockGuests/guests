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
  (defun trim-comment (str)
    (let ((pos ((@ str search) ",")))
      (if (> pos 0)
          ((@ str substr) 0 pos)
          str)))

  (defun select-photo (container card row)
    (show-image-gallery (@ container images) (@ card index)))

  (defun create-photo (parent row index)
    (let ((card (create-element "paper-card" parent "pack")))
      (setf (@ card row) row
            (@ card row url) (row-url row)
            (@ card index) index)
      (on "click"
          (set-html* card
                     ((:div :class "card-content photo")
                      (when (@ row thumbnail)
                        (ps-html ((:img :src (+ "data:" (@ row mime) ";base64," (@ row thumbnail))))))
                      (when (@ row comment)
                        (ps-html ((:div :class "attr")
                                  ((:div :class "desc") (trim-comment (@ row comment))))))))
          (select-photo (@ parent parent-node) card row))))

  (defun create-image-array (rows)
    (loop for row in rows
          collect (create :src (@ row url) :w (@ row width) :h (@ row height)
                          :title (@ row comment))))

  (defun show-photos ()
    (select-page 7)
    (render-file-listing
     "photos" "/photos/"
     :parent-type "div" :class-name "grid" :parent-id "photo-grid"
     :create-controls-fn nil :create-headings-fn nil
     :create-row-fn create-photo
     :continuation (lambda (el)
                     (setf (@ el images) (create-image-array (@ el rows)))
                     (pack "photo-grid")))

))

