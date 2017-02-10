(in-package :guests)

(defun render-front (stream)
  (header-panel :mode "seamed"
    (toolbar :class "time"
      (:span :style "margin-left:0px;" :class "title" "Standing Rock Guests"))
    (button :onclick "page(\"/time\");" "time")
    (button :onclick "page(\"/signs\");" "sign language")
    (button :onclick "page(\"/wiki\");" "wiki")



    ))
