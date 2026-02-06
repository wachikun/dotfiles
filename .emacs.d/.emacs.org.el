;;; -*- lexical-binding: t; -*-

(setq org-startup-folded t)
(setq org-image-actual-width '(400))
(setq org-mode-hook '(lambda ()
                       (org-show-all)
                       (define-key org-mode-map "\M-h" 'backward-kill-word)))
