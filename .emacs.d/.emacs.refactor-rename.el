(defvar refactor-rename--from-to nil)

(defun refactor-rename ()
  (let* ((separator-regexp "[^0-9a-zA-Z_-]")
         (separator-group-regexp (concat "\\(" separator-regexp "\\)"))
         (from-string (read-from-minibuffer (if refactor-rename--from-to
                                                (concat "from?: (default "
                                                        (car refactor-rename--from-to)
                                                        query-replace-from-to-separator
                                                        (cdr refactor-rename--from-to)
                                                        "): ")
                                              "from?: ")
                                            (thing-at-point 'symbol)))
         to-string
         from-string-regexp
         from-string-emacs-regexp
         to-string-emacs-regexp)
    (if (string= "" from-string)
        (progn
          (setq from-string (car refactor-rename--from-to))
          (setq to-string (cdr refactor-rename--from-to)))
      (setq to-string (read-from-minibuffer "to?: "
                                            (thing-at-point 'symbol))))
    (setq from-string-regexp (concat separator-regexp from-string separator-regexp))
    (setq from-string-emacs-regexp (concat separator-group-regexp from-string
                                           separator-group-regexp))
    (setq to-string-emacs-regexp (concat "\\1" to-string "\\2"))
    (compilation-start (concat "grep_refactor_rename '" from-string-regexp
                               "' " to-string)
                       'grep-mode
                       (lambda (name)
                         "*refactor rename*"))
    (save-excursion
      (goto-char (point-min))
      (query-replace-regexp from-string-emacs-regexp
                            to-string-emacs-regexp))
    (setq refactor-rename--from-to (cons from-string to-string))))

(defun RENAME ()
  (interactive)
  (refactor-rename))
