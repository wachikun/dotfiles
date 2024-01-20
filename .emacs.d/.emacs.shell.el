(setq comint-input-ring-size 1024)

(defadvice comint-next-matching-input-from-input
    (around comint-next-matching-input-from-input-around
            activate)
  (let ((case-fold-search nil))
    ad-do-it))

(defadvice comint-previous-matching-input-from-input
    (around comint-previous-matching-input-from-input-around
            activate)
  (let ((case-fold-search nil))
    ad-do-it))


(add-to-list 'display-buffer-alist
             '("\\*shell\\*" . (display-buffer-same-window)))
(setq shell-mode-hook '(lambda ()
                         (define-key shell-mode-map "\M-\C-l" 'switch-to-other-buffer)
                         (define-key shell-mode-map "\M-p" 'comint-previous-matching-input-from-input)
                         (define-key shell-mode-map "\M-n" 'comint-next-matching-input-from-input)))

;; sh
(setq sh-loop 0)

(defun setup-home-shell (bufname &optional shell-command query-on-exit-p)
  (let ((default-directory "~/"))
    (shell)
    (with-current-buffer "*shell*"
      (set-buffer-process-coding-system 'utf-8 'utf-8)
      (rename-buffer bufname)
      (switch-to-buffer bufname)
      (when shell-command
        (process-send-string bufname shell-command))
      (set-process-query-on-exit-flag (get-buffer-process bufname)
                                      query-on-exit-p))))

(defun sh ()
  "utf-8-japan shell"
  (interactive)
  (let (bufname)
    (setq sh-loop (+ sh-loop 1))
    (setq bufname (concat "*utf-8-japan shell*"
                          (number-to-string sh-loop)))
    (shell)
    (with-current-buffer "*shell*"
      (set-buffer-process-coding-system 'utf-8 'utf-8)
      (rename-buffer bufname)
      (switch-to-buffer bufname))))

(defun sh-delete-all-processes ()
  (interactive)
  (if (y-or-n-p "kill all processes?")
      (progn
        (let ((loop 5))
          (catch 'loop
            (while (>= loop 0)
              (unless (process-list)
                (throw 'loop nil))
              (setq loop (1- loop))
              (mapc #'(lambda (a)
                        (when (string-match "^shell" (process-name a))
                          (process-send-string a " \n")
                          (sleep-for 0.1)
                          (process-send-string a " \n")
                          (sleep-for 0.1)
                          (process-send-string a " exit\n")))
                    (process-list))
              (sleep-for 1))))
        (mapc #'(lambda (a)
                  (when (string-match "^shell" (process-name a))
                    (delete-process a)))
              (process-list))
        (message "Delete all shell processes."))
    (message "Not deleted.")))
