(in-package :guests)

(require 'story-modules)

(defun initialize ()
  (load-signs)
  (story:initialize-story)
  (story:story "guests")
  (format t "Welcome to Standing Rock Guests!~%")
  (format t "~%~A~%" (blue (text "Standing Rock Guests!" :font "standard"))))
