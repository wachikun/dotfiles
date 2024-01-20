(defun init-el-rustic ()
  (add-to-list 'exec-path
               (expand-file-name "~/.cargo/bin/"))
  (use-package rustic
    :init (add-hook 'company-mode-hook
                    (lambda ()
                      (yas-minor-mode)
                      (set (make-variable-buffer-local 'company-idle-delay)
                           0.2)
                      (set (make-variable-buffer-local 'company-minimum-prefix-length)
                           1)
                      (set (make-variable-buffer-local 'company-tooltip-align-annotations)
                           t)
                      (define-key company-active-map "\C-h" 'delete-backward-char)
                      (define-key company-active-map "\C-n" 'company-select-next)
                      (define-key company-active-map "\C-p" 'company-select-previous)
                      (define-key company-active-map "\M-<" '(lambda ()
                                                               (interactive)
                                                               (company-set-selection 0)))
                      (define-key company-active-map "\M->" '(lambda ()
                                                               (interactive)
                                                               (company-set-selection (1- company-candidates-length))))
                      ;; pub(crate) fn func() のような形式だと rustic-beginning-of-defun が正常動作しないので対策
                      (setq rustic-top-item-beg-re (concat "\\s-*\\(?:priv\\|pub\\(([^)]+)\\)?\\)?\\s-*"
                                                           (regexp-opt '("enum" "struct" "union" "type" "mod" "use"
                                                                         "async fn" "const fn" "fn" "static [^r]" "impl"
                                                                         "extern" "trait"))
                                                           "\\_>"))
                      (advice-add 'flycheck-list-errors :around 'adviced-flycheck-list-errors)
                      (advice-add 'rustic-format-buffer :around 'adviced-rustic-format-buffer)))(add-hook 'rustic-compilation-mode-hook
                    (lambda ()
                      (define-key rustic-compilation-mode-map "g"
                                  'cheat-sheet-rerun))))
  (use-package lsp-rust
    :custom (lsp-rust-analyzer-cargo-watch-command "clippy")(lsp-rust-analyzer-server-display-inlay-hints
                                                             t)(lsp-rust-analyzer-display-chaining-hints
                                                             t)(lsp-rust-analyzer-display-parameter-hints
                                                             t)))

(defun adviced-rustic-format-buffer (orig-func &rest args)
  ;; rustic-format-buffer は非同期実行されるので、ある程度待って何度か復帰させていることに注意
  (save-window-excursion (save-window-excursion (save-window-excursion (save-window-excursion (save-window-excursion (apply orig-func args)
                                                                                                                     (sleep-for 0.1))
                                                                                              (sleep-for 0.1))
                                                                       (sit-for 0.1))
                                                (sit-for 0.1))
                         (sit-for 0.1))
  (sit-for 0.1))

(defun adviced-flycheck-list-errors (orig-func &rest args)
  (apply orig-func args)
  (face-spec-set 'lsp-lsp-flycheck-info-unnecessary-face
                 '((t (:foreground "dim gray"
                                   :underline (:color "ForestGreen" :style wave)))))
  (face-spec-set 'lsp-lsp-flycheck-warning-unnecessary-face
                 '((t (:foreground "dim gray"
                                   :underline (:color "dark red" :style wave)))))
  (face-spec-set 'lsp-flycheck-info-unnecessary-face
                 '((t (:foreground "dim gray"
                                   :underline (:color "ForestGreen" :style wave)))))
  (face-spec-set 'lsp-flycheck-warning-unnecessary-face
                 '((t (:foreground "dim gray"
                                   :underline (:color "dark red" :style wave))))))

(init-el-rustic)
