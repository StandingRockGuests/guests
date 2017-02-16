(in-package :guests)

(defparameter *wiki-directory* (guests-file "wiki/"))

(defun render-wiki (stream)
  (header-panel :main t :mode "seamed"
    (toolbar :class "time"
      (:span :style "margin-left:0px;" :id "wiki-title" :class "title" "Wiki")
      (icon-button :class "toolbar-icon" :style "margin-left:0px;" :icon "arrow-back" :onclick "page(\"/\");"))
    ;; (:div :id "wiki-controls" :style "padding:10px;"
    ;;       (:button :onclick (ps (view-wiki-home)) "Home") " "
    ;;       (:button :onclick (ps (reload-wiki)) "Reload") " "
    ;;       ;; (:button :onclick (ps (edit-wiki)) "Edit") " "
    ;;       ;; (:button :onclick (ps (view-wiki-source)) "View Source")
    ;;       )
    ;; (:br)
    (drawer-panel :right-drawer t
      (:div :main t :id "wiki-body")
      (:div :drawer t :id "wiki-tree" :style "padding-left:20px;width:200px;" (render-wiki-tree stream)))))

(in-package :story-js)

(define-script wikisetup
  (setup-wiki :title "Standing Rock Guests Wiki"
              :url "/wiki-data/"
              :title-id "wiki-title"
              :body-id "wiki-body"
              :prefix "wiki/"))
