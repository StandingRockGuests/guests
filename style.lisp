(in-package :story-css)

(defun guests-style ()
  (style (:is "custom-style")
    `(

      (":root"
       :background black
       :color white
       :--primary-color ,(color blue-grey 900)
       :--primary-background-color black
       :--light-primary-color ,(color blue-grey 300)
       :--accent-color ,(color yellow 200 t)

       :--paper-toolbar-color white
       :--paper-toolbar-title ,(app --paper-font-headline)

       :--paper-spinner-color white

       (:--paper-fab :color white)
       :--paper-fab-keyboard-focus-background ,(color yellow 100 t)

       :--paper-card-background-color ,(color grey 900)

       )

      (".sign" :cursor pointer :margin 5px :max-width 400px)

      (".sn" :padding 20px)

      (".wiki-title" :padding 10px :font ,(var --paper-font-headline))

      ("#wiki-body" :overflow-y auto :padding 10px)
      ("#wiki-tree" :overflow-y auto :padding 10px)

      ("#quotes" :padding 20px)
      (".quote" :padding 20px)
      (".quote .attr" :text-align :right :padding-top 20px)

      ("#photos" :padding 20px)
      (".photo" :width 200px)
      (".photo .attr" :padding-top 20px :text-align :center)

      ;; timeline-entry
      (".te" :width 200px :height 200px :white-space wrap)

      )))
