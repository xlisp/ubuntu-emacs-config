
(defun to-hulu
    (text)
  (call-process
   "curl" nil 0 t
   my-hulu-api
   "-s"
   "-H"
   "Content-Type: application/json"
   "-d"
   (format "{\"content\": \"%s\"}" (replace-regexp-in-string "\"" "\\\\\"" text))))

(defun dc-selected-region-to-hulu ()
  (interactive)
  (unless (use-region-p)
    (user-error "Please select text"))
  (message (to-hulu (buffer-substring (region-beginning)  (region-end)))))

(defun cur-line-to-hulu ()
  (interactive)
  (message (to-hulu (buffer-substring (line-beginning-position)  (line-end-position))))
  (evil-force-normal-state))

(provide 'jim-hulu)
