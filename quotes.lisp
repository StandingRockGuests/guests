(in-package :guests)

(defdataloader quotes :json t)

(define-template quote-card
  :style ((":host" :margin 10px :display inline-block)
          (".quote" :padding 20px :max-width 500px)
          (".quote .attr" :text-align :right :padding-top 20px))
  :content
  ((card
     (:div :class "card-content quote"
           (:div "“{{text}}”")
           (:div :class "attr"
                 (:div "— {{name}}")
                 (:div "{{description}}"))))))

(defun render-quotes (stream)
  (header-panel :mode "seamed"
    (toolbar :class "time"
      (:span :style "margin-left:0px;" :class "title" "Quotes")
      (icon-button :class "toolbar-icon" :style "margin-left:0px;"
        :icon "arrow-back" :onclick "page(\"/\");"))
    (:template-grid :source "quotes.json" :renderer "renderQuote")
    (script
      (defun render-quote (el)
        (create-el "quote-card" (create :text (aref el 0)
                                        :name (aref el 1)
                                        :description (aref el 2)))))))




