(in-package :guests)

;; '("great mystery" "work" "sunrise" "you" "heart")

(define-story guests (:title "Standing Rock Guests"
                      :imports (("style" story-css:guests-style))
                      :scripts (("guests.js" guests-js))
                      :package :guests
                      :modules (:roboto :page :echo :polymer
                                :iron-flex-layout :iron-icons
                                :iron-collapse
                                :neon-animatable :neon-animated-pages
                                :fade-in-animation :fade-out-animation
                                :paper-ripple :paper-button :paper-icon-button
                                :paper-header-panel :paper-toolbar
                                :paper-item :paper-listbox :paper-drawer-panel
                                :paper-card :images :packery
                                :suncalc :wiki :vis :files
                                :image-gallery)
                      :page-args (:body-class "fullbleed layout vertical")
                      :publish-directory (guests-file "build/")
                      :cname "standingrockguests.org"
                      :header guests-header
                      :footer guests-footer
                      :directories ("signs" "photos")
                      :dispatches ((:folder "/wiki-data/" *wiki-directory*)))
  (:style :is "custom-style" :include "iron-flex iron-flex-alignment iron-positioning")
  (animated-pages :id "pages" :class "flex" :style "padding:20px;"
    :entry-animation "fade-in-animation"
    :exit-animation "fade-out-animation"
    :selected 0
    (animatable)       ; initial loading shows and transitions to next
    (animatable (render-front stream))
    (animatable ; (render-time stream)
      )
    (animatable (render-signs stream
                              '("great mystery" "work" "sunrise" "you" "heart")
                              ))
    (animatable ; (render-wiki stream)
      )
    (animatable ; (render-timeline stream)
      )
    (animatable ; (render-quotes stream)
      )
    (animatable (render-photos stream)))
  (script
    (when-ready (lambda ()
                  (setup-routing)))))

(defun guests-header (stream)
  (comment (as-string (text "Welcome to S'Rock Guests!" :font "emboss2"))))

(defun guests-footer (stream)
  (comment (as-string (text ">>>> Join Us! <<<<" :font "pagga"))))

(in-package :story-js)

(defun guests-js ()
  (concatenate 'string (main) (moontime) (wikisetup) (signs) (timeline-js) (photos)))

(define-script main
  (defun select-page (index)
    (let ((pages (id "pages")))
      (unless (=== (@ pages selected) index)
        (setf (@ pages selected) index)))
    ((@ echo render)))

  (defun setup-routing ()
    (page "/" (lambda () (select-page 1)))
    (page "/time" (lambda () (update-time) (select-page 2)))
    (page "/signs" (lambda () (select-page 3)))
    (page "/wiki/:page" (lambda (ctx) (select-page 4) (fetch-wiki-page (@ ctx params page))))
    (page "/wiki" (lambda () (select-page 4) (page "/wiki/Home")))
    (page "/timeline" (lambda () (setup-timeline) (select-page 5)))
    (page "/quotes" (lambda () (select-page 6) (pack "quotes")))
    (page "/photos" show-photos)
    (page (create :hashbang t)))

  (defun visit-wiki ()
    (visit-url "https://github.com/StandingRockGuests/StandingRockGuests.github.io/wiki"))

)
