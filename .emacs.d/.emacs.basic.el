(set-file-name-coding-system 'utf-8)

(setq eval-expression-print-length nil)
(setq eval-expression-print-level nil)

(setq-default indent-tabs-mode nil)

;; miscellaneous
(setq passwd-invert-frame-when-keyboard-grabbed
      nil)
(setq mail-signature t)

(setq scroll-step 1)
(setq next-line-add-newlines nil)

(setq x-select-enable-primary t)
(setq x-select-enable-clipboard nil)
(setq select-active-regions nil)
(setq delete-active-region nil)

;; BSD with tab8 and NO TAB
(c-add-style "custom"
             '((indent-tabs-mode . nil)
               (c-basic-offset . 8)
               (c-comment-only-line-offset . 0)
               (c-offsets-alist . ((statement-block-intro . +)
                                   (knr-argdecl-intro . +)
                                   (substatement-open . 0)
                                   (substatement-label . 0)
                                   (label . 0)
                                   (statement-cont . 0)
                                   (statement-case-open . +)
                                   (innamespace . 0)
                                   (inline-open . 0)
                                   (inexpr-class . 0))))
             nil)


;; suffixes
(setq completion-ignored-extensions (cons ".d" completion-ignored-extensions))
(setq completion-ignored-extensions (cons ".o" completion-ignored-extensions))

(setq auto-mode-alist (append '(("\\.cg$" . c++-mode)
                                ("\\.vert$" . c++-mode)
                                ("\\.geom$" . c++-mode)
                                ("\\.frag$" . c++-mode)
                                ("\\.txt" . text-mode))
                              auto-mode-alist))
