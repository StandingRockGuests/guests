(in-package :guests-parsing)

(defun page-links (raw)
  (let ((doc (parse raw (make-builder)))
        rtn)
    (stp:do-recursively (a doc)
      (when (and (typep a 'element)
                 (equal (local-name a) "a"))
        (push (list (attribute-value a "href") (string-value a)) rtn)))
    (nreverse rtn)))



