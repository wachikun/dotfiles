;;; -*- lexical-binding: t; -*-

(setq backup-by-copying t)
(setq delete-auto-save-files nil)

(setq version-control t)
(setq kept-new-versions 128)
(setq kept-old-versions 9)

(let ((directory (format "/tmp/.emacs.backup.%d/"
                         (user-real-uid))))
  (unless (file-accessible-directory-p directory)
    (make-directory directory))
  (set-file-modes directory ?\700)
  (setq backup-directory-alist (cons (cons ".*" (expand-file-name directory)) backup-directory-alist))
  (setq auto-save-file-name-transforms `((".*" ,(expand-file-name directory)
                                          t))))
