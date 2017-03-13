(in-package :guests-parsing)

(defun string-starts-with (string prefix &key (test #'char=))
  "Returns true if STRING starts with PREFIX."
  (let ((mismatch (mismatch prefix string :test test)))
    (or (not mismatch) (= mismatch (length prefix)))))

(defun page-links (raw)
  (let ((doc (parse raw (make-builder)))
        rtn)
    (stp:do-recursively (a doc)
      (when (and (typep a 'element)
                 (equal (local-name a) "a"))
        (push (list (attribute-value a "href") (string-value a)) rtn)))
    (nreverse rtn)))



