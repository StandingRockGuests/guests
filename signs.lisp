(in-package :guests)

(defparameter *signs-directory* (guests-file "signs/"))

(defdataloader signs :json t)

(define-template sign-card
    :style ((paper-card :margin 5px :cursor pointer)
            (".sn" :padding 20px))
  :properties (("index" number 1)
               ("title" string "foo")
               ("description" string)
               ("has-image" boolean)
               ("image" string)
               ("image-position" object))
  :content ((card
              (:div :class "card-content"
                    :onclick$ "toggleSign({{index}})"
                    (:div :hidden$ "{{!image}}"
                          :style$ "width:{{image-position.w}}px;height:{{image-position.h}}px"
                          (:img
                           :style$ "position:absolute;clip:rect({{image-position.top}}px,{{image-position.right}}px,{{image-position.bottom}}px,{{image-position.left}}px);margin-left:-{{image-position.left}}px;margin-top:-{{image-position.top}}px;"
                           :src$ "/signs/s{{image}}.png"))
                    (:span :hidden$ "{{image}}" "{{title}}")
                    (collapse :id "sn-{{index}}"
                      (:div :class "sn" "{{description}}"))))))

(defun render-signs (stream)
  (header-panel :mode "seamed"
    (toolbar :class "time"
      (:span :style "margin-left:0px;" :class "title" "Sign Language")
      (icon-button :class "toolbar-icon" :style "margin-left:0px;"
        :icon "arrow-back" :onclick "page(\"/\");"))
    (:div :id "signs")))

(in-package :story-js)

(defun signs-json () guests::*signs-json*)

(define-script signs
  (defvar *signs*)

  (defun setup-signs ()
    (fetch-json "signs.json"
                (lambda (el)
                  (setf *signs* el)
                  (create-signs))))

  (defun create-signs ()
    (let ((parent (id "signs")))
      (loop for sign in *signs*
            for index from 1 to 100
            do (create-el
                :sign-card
                (create :title (aref sign 0)
                        :index index
                        :description (if (= (length sign) 4)
                                         (aref sign 3) (aref sign 1))
                        :image (and (= (length sign) 4) (aref sign 1))
                        :image-position (and (= (length sign) 4)
                                             (destructuring-bind (x y w h) (aref sign 2)
                                               (create w w h h top y right (+ x w) bottom (+ y h) left x))))
                parent))))

  (defun toggle-sign (index)
    (let ((el (id (+ "sn-" index))))
      ((@ el toggle))))



  )
