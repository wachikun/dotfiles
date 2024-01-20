(setq line-number-mode t)
(setq column-number-mode t)

(set-scroll-bar-mode nil)
(when (fboundp 'set-horizontal-scroll-bar-mode)
  (set-horizontal-scroll-bar-mode nil))
(tool-bar-mode -1)
(menu-bar-mode -1)
