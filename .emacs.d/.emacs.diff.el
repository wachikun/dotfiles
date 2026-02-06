(setq diff-default-read-only t)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq-default ediff-auto-refine-limit 100000)

(setq my-ediff-window-configuration nil)
(setq ediff-before-setup-windows-hook
      '(lambda ()
         (setq my-ediff-window-configuration (current-window-configuration))))
(setq ediff-quit-hook
      '(lambda ()
         (when my-ediff-window-configuration
           (set-window-configuration my-ediff-window-configuration))))
