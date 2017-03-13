(defsystem "guests"
  :description "none"
  :version "0.1"
  :author "William Halliburton"
  :license "unknown"
  :serial t
  :depends-on ("story" "story-module-polymer" "story-module-suncalc" "story-module-wiki"
                       "story-module-files" "cl-ascii-art")
  :components ((:static-file "guests.asd")
               (:file "package")
               (:file "utility")
               (:file "style")
               (:file "front")
               (:file "time")
               (:file "signs")
               (:file "quotes")
               (:file "wiki")
               (:file "timeline")
               (:file "photos")
               (:file "main")
               (:file "initialize")))
