(in-package :guests)

(define-story guests (:title "Standing Rock Guests"
                :imports (("style" guests-style))
                :scripts (("guests.js" guests-js))
                :package :guests
                :modules (:roboto)
                :page-args (:body-class "fullbleed layout vertical")
                :publish-directory (guests-file "build/")
                :cname "standingrockguests.org"
                :header guests-header
                :footer guests-footer)
    ;;  (:style :is "custom-style" :include "iron-flex iron-flex-alignment iron-positioning")
  )

(defun guests-header (stream)
  (comment (as-string (text "Welcome to S'Rock Guests!" :font "emboss2"))))

(defun guests-footer (stream)
  (comment (as-string (text ">>>> Join Us! <<<<" :font "pagga"))))

(in-package :story-js)

(defun guests-js ()
  (concatenate 'string (main)))

(define-script main

  (defun visit-wiki ()
    (visit-url "https://github.com/Blue-Sky-Skunkworks/missoula-civic-hackathon-notes/wiki"))

)
