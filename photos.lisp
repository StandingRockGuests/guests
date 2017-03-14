(in-package :guests)

(defparameter *photo-directory* (guests-file "photos/"))

(defun render-photos (stream)
  (header-panel :mode "seamed"
    (toolbar :class "time"
      (:span :style "margin-left:0px;" :class "title" "Photos")
      (icon-button :class "toolbar-icon" :style "margin-left:0px;" :icon "arrow-back" :onclick "page(\"/\");"))
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

  (defun create-photo (parent row)
    (let ((card (create-element "paper-card" parent "pack")))
      (on "click"
          (set-html* card
                     ((:div :class "card-content photo")
                      (when (@ row thumbnail)
                        (ps-html ((:img :src (+ "data:" (@ row mime) ";base64," (@ row thumbnail))))))
                      (when (@ row comment)
                        (ps-html ((:div :class "attr")
                                  ((:div :class "desc") (trim-comment (@ row comment))))))))
          (funcall *select-row-fn* row))))

  (defun show-photos ()
    (select-page 7)
    (render-file-listing "photos" "/photos/" :rerender t
                                           :parent-type "div" :class-name "grid"
                                           :parent-id "photo-grid"
                                           :create-controls-fn nil
                                           :create-headings-fn nil
                                           :create-row-fn create-photo)
    (pack "photo-grid")))

