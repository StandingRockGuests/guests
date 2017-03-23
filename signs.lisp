(in-package :guests)

(defparameter *signs-directory* (guests-file "signs/"))

(defdataloader signs :json t)

(define-template sign-card
    :style ((paper-card :margin 5px :cursor pointer)
            (".sn" :padding 20px))
  :properties (("index" number 1)
               ("title" string "foo")
               ("description" string)
               ("image" string nil)
               ("position" object))
  :content ((card
              (:div :class "card-content"
                    :onclick$ "toggleSign({{index}})"
                    (:div :hidden$ "{{!image}}"
                          :style$ "width:{{position.w}}px;height:{{position.h}}px"
                          (:img
                           :style$ "position:absolute;clip:rect({{position.top}}px,{{position.right}}px,{{position.bottom}}px,{{position.left}}px);margin-left:-{{position.left}}px;margin-top:-{{position.top}}px;"
                           :src$ "/signs/s{{image}}.png"))
                    (:span :hidden$ "{{image}}" "{{title}}")
                    (collapse :id "sn-{{index}}"
                      (:div :class "sn" "{{description}}"))))))

(define-template sign-grid
  :content
  ((:h1 "signs")
   (dom-repeat :items "{{signData}}"
     (:sign-card :title "{{item.title}}" :index "{{index}}" :image "{{item.image}}"
                 :position "{{item.position}}" :description "{{item.description}}"))))

(defun render-signs (stream)
  (header-panel :mode "seamed"
    (toolbar :class "time"
      (:span :style "margin-left:0px;" :class "title" "Sign Language")
      (icon-button :class "toolbar-icon" :style "margin-left:0px;"
        :icon "arrow-back" :onclick "page(\"/\");"))
    (:sign-grid :id "signs")))

(in-package :story-js)

(defun signs-json () guests::*signs-json*)

(define-script signs

  (defun setup-signs ()
    (fetch-json "signs.json"
                (lambda (el)
                  (create-signs el))))

  (defun create-signs (data)
    (setf (@ (id "signs") sign-data)
          (loop for sign in data
                for index from 1 to 100
                collect
                (create :title (aref sign 0)
                        :description (if (= (length sign) 4)
                                         (aref sign 3) (aref sign 1))
                        :image (and (= (length sign) 4) (aref sign 1))
                        :position (and (= (length sign) 4)
                                       (destructuring-bind (x y w h) (aref sign 2)
                                         (create w w h h top y right (+ x w)
                                                 bottom (+ y h) left x)))))))

  (defun toggle-sign (index)
    (let ((el (id (+ "sn-" index))))
      ((@ el toggle))))

  )
