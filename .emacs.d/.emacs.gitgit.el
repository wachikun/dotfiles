;;; -*- lexical-binding: t; -*-

(require 'gitgit)

(setq auto-mode-alist (append '(("\\.texe" . texe-mode))
                              auto-mode-alist))

(defun OV ()
  (interactive)
  (let (buffer)
    (catch 'loop
      (mapc #'(lambda (a)
                (let (buffer-name)
                  (setq buffer-name (buffer-name a))
                  (when (string-match "^\\*gitgit\\*.+ status$" buffer-name)
                    (setq buffer buffer-name)
                    (throw 'loop nil))))
            (buffer-list)))
    (if buffer
        (switch-to-buffer buffer)
      (catch 'loop
        (mapc #'(lambda (a)
                  (let (buffer-name)
                    (setq buffer-name (buffer-name a))
                    (when (string-match "\\.texe\\b" buffer-name)
                      (with-current-buffer buffer-name
                        (when (and (boundp 'texe-mode)
                                   texe-mode)
                          (setq buffer buffer-name)
                          (throw 'loop nil))))))
              (buffer-list)))
      (if buffer
          (switch-to-buffer buffer)
        (message "buffer not found!")))))
