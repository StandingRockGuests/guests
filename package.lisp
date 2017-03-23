
(defpackage guests
  (:use common-lisp story iterate cl-who cl-css cl-ascii-art split-sequence)
  (:import-from story-js console)
  (:import-from uiop directory-files)
  (:import-from alexandria if-let)
  (:import-from asdf/run-program run-program))

;; (defpackage guests-parsing
;;   (:use common-lisp story iterate closure-html cxml-stp drakma trivial-download)
;;   (:import-from alexandria with-output-to-file))
