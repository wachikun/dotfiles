;;; -*- lexical-binding: t; -*-

(require 'google-translate)

(defun google-translate--search-tkk ()
  "Search TKK."
  (list 430675 2721866130))

(setq google-translate-listen-program (executable-find "mplayer_for_google_translate"))

(defun TRANSLATE ()
  (interactive)
  (let (string)
    (if mark-active
        (setq string (buffer-substring (region-beginning)
                                       (region-end)))
      (setq string (read-from-minibuffer "keyword?: "
                                         (thing-at-point 'symbol))))
    (if (string-match "\\cj" string)
        (google-translate-translate "ja" "en" string)
      (google-translate-translate "en" "ja" string))))
