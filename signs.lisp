(in-package :guests)

(defparameter *signs-directory* (guests-file "signs/"))

(defdataloader signs)

(defun render-signs (stream)
  (header-panel :mode "seamed"
    (toolbar :class "time"
      (:span :style "margin-left:0px;" :class "title" "Sign Language")
      (icon-button :class "toolbar-icon" :style "margin-left:0px;" :icon "arrow-back" :onclick "page(\"/\");"))
    (:div
     :id "signs"
     (iter (for el in *signs*)
       (for index from 1 to 200)
       (destructuring-bind (name image pos text)
           (if (= (length el) 2)
               (list (first el) nil nil (second el))
               el)
         (card :class "sign"
           (:div :class "card-content"
                 :onclick (ps* `(toggle-sign ,index))
                 (if image
                   (destructuring-bind (x y w h) pos
                     (htm (:div
                           :style (format nil "width:~Apx;height:~Apx;" w h)
                           (:img
                            :style (format nil "position:absolute;clip:rect(~Apx,~Apx,~Apx,~Apx);margin-left:-~Apx;margin-top:-~Apx" y (+ x w) (+ y h) x x y)
                            :src (format nil "/signs/s~A.png" image)))))
                   (str (if (consp name) (format nil "~{~A~^/~}" name) name)))
                 (collapse :id (format nil "sn-~A" index)
                   (:div :class "sn"
                         (if (stringp text) (esc text)
                             (esc (car text))))))))))))

(in-package :story-js)

(define-script signs
  (defun toggle-sign (index)
    (let ((el (id (+ "sn-" index)))))
    ((@ el toggle))))
