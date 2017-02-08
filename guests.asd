(defsystem "guests"
  :description "none"
  :version "0.1"
  :author "William Halliburton"
  :license "unknown"
  :serial t
  :depends-on ("story" "story-module-polymer" "cl-ascii-art")
  :components ((:static-file "guests.asd")
               (:file "package")
               (:file "utility")
               (:file "style")
               (:file "front")
               (:file "time")
               (:file "main")
               (:file "initialize")))
