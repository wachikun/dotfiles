(require 'gitgit)

(defun OV ()
  (interactive)
  (let (buffer)
    (mapc #'(lambda (a)
              (unless buffer
                (let (buffer-name)
                  (setq buffer-name (buffer-name a))
                  (cond
                   ((string-match "^\\*gitgit\\*.+ status$" buffer-name)
                    (setq buffer buffer-name))))))
          (buffer-list))
    (if buffer
        (switch-to-buffer buffer)
      (message "buffer not found!"))))
