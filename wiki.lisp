(in-package :guests)

(defparameter *wiki-directory* (guests-file "wiki/"))

(defun render-wiki (stream)
  (header-panel :mode "seamed"
    (toolbar :class "time"
      (:span :style "margin-left:0px;" :class "title" "Wiki")
      (icon-button :class "toolbar-icon" :style "margin-left:0px;" :icon "arrow-back" :onclick "page(\"/\");"))
    (:div :id "wiki-title")
    (:br)
    (:div :id "wiki-controls"
          (:button :onclick (ps (view-wiki-home)) "Home") " "
          (:button :onclick (ps (reload-wiki)) "Reload") " "
          ;; (:button :onclick (ps (edit-wiki)) "Edit") " "
          ;; (:button :onclick (ps (view-wiki-source)) "View Source")
          )
    (:br)
    (:div :id "wiki-tree" (render-wiki-tree stream))
    (:div :id "wiki-body")))

(in-package :story-js)

(define-script wikisetup
  (setup-wiki :title "Standing Rock Guests Wiki"
              :url "/wiki-data/"
              :title-id "wiki-title"
              :body-id "wiki-body"
              :prefix "wiki/"))
