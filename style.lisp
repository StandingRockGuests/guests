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

      )))
