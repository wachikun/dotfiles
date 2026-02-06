;;; -*- lexical-binding: t; -*-

(defun to-snake ()
  (interactive)
  (let ((case-fold-search nil)
        (string))
    (if mark-active
        (let ((begin (region-beginning))
              (tmp))
          (setq string (buffer-substring begin
                                         (region-end)))
          (when (string-match "^\\([A-Z]\\)" string)
            (setq tmp (downcase (match-string 1 string)))
            (setq string (concat tmp
                                 (buffer-substring (+ begin 1)
                                                   (region-end)))))
          (delete-region begin
                         (region-end)))
      (re-search-forward "\\(\\w+\\)\\s-?(")
      (goto-char (- (point)
                    1))
      (setq string (match-string 1))
      (delete-region (match-beginning 1)
                     (match-end 1)))
    (while (string-match "\\([^A-Z]+\\)\\([A-Z]\\)\\(.*\\)"
                         string)
      (setq string (concat (match-string 1 string)
                           "_"
                           (downcase (match-string 2 string))
                           (match-string 3 string))))
    (insert string)))

(defun to-lower-camel ()
  (interactive)
  (let ((case-fold-search nil)
        (string))
    (if mark-active
        (progn
          (setq string (buffer-substring (region-beginning)
                                         (region-end)))
          (delete-region (region-beginning)
                         (region-end)))
      (re-search-forward "\\([a-zA-Z0-9_]+\\)\\s-?(")
      (goto-char (- (point)
                    1))
      (setq string (match-string 1))
      (delete-region (match-beginning 1)
                     (match-end 1)))
    (while (string-match "\\([^_]+\\)_\\([a-zA-Z]\\)\\(.*\\)"
                         string)
      (setq string (concat (match-string 1 string)
                           (upcase (match-string 2 string))
                           (match-string 3 string))))
    (insert string)))

(defun to-upper-camel ()
  (interactive)
  (let ((case-fold-search nil)
        (string))
    (if mark-active
        (progn
          (setq string (buffer-substring (region-beginning)
                                         (region-end)))
          (delete-region (region-beginning)
                         (region-end)))
      (re-search-forward "\\([a-zA-Z0-9_]+\\)\\s-?(")
      (goto-char (- (point)
                    1))
      (setq string (match-string 1))
      (delete-region (match-beginning 1)
                     (match-end 1)))
    (while (string-match "\\([^_]+\\)_\\([a-zA-Z]\\)\\(.*\\)"
                         string)
      (setq string (concat (match-string 1 string)
                           (upcase (match-string 2 string))
                           (match-string 3 string))))
    (when (string-match "\\([a-zA-Z]\\)\\(.*\\)" string)
      (setq string (concat (upcase (match-string 1 string))
                           (match-string 2 string))))
    (insert string)))
