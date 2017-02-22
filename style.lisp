(in-package :story-css)

(defun guests-style ()
  (style (:is "custom-style")
    `(

      (":root"
       :--primary-color ,(color purple 500)
       :--light-primary-color ,(color blue 500)
       :--accent-color ,(color yellow 200 t)

       :--paper-toolbar-color white
       :--paper-toolbar-title ,(app --paper-font-headline)

       :--paper-spinner-color white

       (:--paper-fab :color black)
       :--paper-fab-keyboard-focus-background ,(color yellow 100 t))

      (".sign" :cursor pointer :padding 5px)

      (".sn" :padding 20px)

      (".wiki-title" :padding 10px :font ,(var --paper-font-headline))

      ("#wiki-body" :overflow-y auto :padding 10px)
      ("#wiki-tree" :overflow-y auto :padding 10px)

      (".quotes" :padding 20px)
      (".quote" :padding 20px)
      (".quote .attr" :text-align :right :padding-top 20px)

      )))
