(defsystem "guests"
  :description "none"
  :version "0.1"
  :author "William Halliburton"
  :license "unknown"
  :serial t
  :depends-on ("story" "story-module-polymer" "cl-ascii-art")
  :components ((:static-file "guests.asd")
               (:file "package")
               (:file "style")
               (:file "main")
               (:file "initialize")))
