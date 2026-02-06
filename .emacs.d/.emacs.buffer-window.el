;;; -*- lexical-binding: t; -*-

(setq display-buffer-fallback-action '((display-buffer--maybe-same-window display-buffer-reuse-window
                                                                          display-buffer--maybe-pop-up-frame-or-window
                                                                          display-buffer-use-some-window display-buffer-pop-up-frame)))

(setq split-width-threshold nil)

(add-hook 'buffer-menu-mode-hook
          (lambda ()
            (cd "~/")))
