(in-package :guests-parsing)


(defun download-loc-image-data (id)
  (let ((doc (parse (http-request
                     (format nil "http://www.loc.gov/pictures/item/~a/" id)) (make-builder)))
        rtn)
    (flet ((trim (str) (string-trim '(#\newline #\space #\return #\tab) str)))
      (stp:do-recursively (a doc)
        (when (and (typep a 'element)
                   (equal (local-name a) "a"))
          (let ((val (string-value a)))
            (when (string-starts-with val "JPEG")
              (push (list :image (trim val) (attribute-value a "href")) rtn))))
        (when (and (typep a 'element)
                   (equal (local-name a) "title"))
          (push (list :title (trim (string-value a))) rtn))))
    rtn))

(defun download-loc-image (id)
  (let* ((data (download-loc-image-data id))
         (image (third (assoc :image data)))
         (name (subseq image (length (directory-namestring image))))
         (filename (guests::guests-file (format nil "photos/~A" name)))
         (url (format nil "http:~A" image))
         (title (second (assoc :title data))))
    (format t "~%~A~%" title)
    (download url filename)
    (story::set-jpeg-comment filename title)
    (story::set-jpeg-credit filename (format nil "loc/pictures/item/~A" id))))

;; 12319
;; 12885
;; 12740
;; 3401 ; incomplete


(defun search-loc-images (&optional (q "LOT 12319"))
  (iter (for (link text) in (page-links (http-request (format nil "http://www.loc.gov/pictures/search/?va=exact&co%21=coll&st=grid&q=~A&fi=number&sg=true&op=PHRASE" (url-encode q :utf-8)))))
    (when (string-starts-with link "//www.loc.gov/pictures/item/")
      (collect (string-right-trim '(#\/) (subseq link 28))))))




