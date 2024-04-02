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
                    (when (string-match "\\.texe$" buffer-name)
                      (setq buffer buffer-name)
                      (throw 'loop nil))))
              (buffer-list)))
      (if buffer
          (switch-to-buffer buffer)
        (message "buffer not found!")))))
