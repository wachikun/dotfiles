(setq diff-default-read-only t)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq-default ediff-auto-refine-limit 100000)

;; これはどこから持ってきたんだろう……
(add-hook 'diff-mode-hook
          '(lambda ()
             (diff-auto-refine-mode t)
             (setq diff-font-lock-keywords `((,(concat "\\(" diff-hunk-header-re-unified
                                                       "\\)\\(.*\\)$")
                                              (1 'diff-hunk-header)
                                              (6 'diff-function))
                                             ("^\\(\\*\\{15\\}\\)\\(.*\\)$"
                                        ;context

                                              (1 'diff-hunk-header)
                                              (2 'diff-function))
                                             ("^\\*\\*\\* .+ \\*\\*\\*\\*" . 'diff-hunk-header) ;context
                                             (,diff-context-mid-hunk-header-re . 'diff-hunk-header) ;context
                                             ("^[0-9,]+[acd][0-9,]+$" . 'diff-hunk-header) ;normal

                                             ("^---$" . 'diff-hunk-header) ;normal
                                             ;; For file headers, accept files with spaces, but be careful to rule
                                             ;; out false-positives when matching hunk headers.
                                             ("^\\(---\\|\\+\\+\\+\\|\\*\\*\\*\\) \\([^\t\n]+?\\)\\(?:\t.*\\| \\(\\*\\*\\*\\*\\|----\\)\\)?\n"
                                              (0 'diff-header)
                                              (2
                                               (if (not (match-end 3))
                                                   'diff-file-header)
                                               prepend))
                                             ("^\\([-<]\\)\\(.*\n\\)"
                                              (1 diff-indicator-removed-face)
                                              (2 'diff-removed))
                                             ("^\\([+>]\\)\\(.*\n\\)"
                                              (1 diff-indicator-added-face)
                                              (2 'diff-added))
                                             ("^\\(!\\)\\(.*\n\\)"
                                              (1
                                               (if diff-use-changed-face
                                                   diff-indicator-changed-face
                                                 ;; Otherwise, search for `diff-context-mid-hunk-header-re' and
	                                         ;; if the line of context diff is above, use `diff-removed';
	                                         ;; if below, use `diff-added'.
                                                 (save-match-data (let ((limit (save-excursion
                                                                                 (diff-beginning-of-hunk))))
                                                                    (if (save-excursion
                                                                          (re-search-backward diff-context-mid-hunk-header-re
                                                                                              limit t))
                                                                        diff-indicator-added-face
                                                                      diff-indicator-removed-face)))))
                                              (2
                                               (if diff-use-changed-face
                                                   'diff-changed
                                                 ;; Otherwise, use the same method as above.
                                                 (save-match-data (let ((limit (save-excursion
                                                                                 (diff-beginning-of-hunk))))
                                                                    (if (save-excursion
                                                                          (re-search-backward diff-context-mid-hunk-header-re
                                                                                              limit t))
                                                                        'diff-added
                                                                      'diff-removed))))))
                                             ("\\({\\+\\)\\(.+\\+}\\)"
                                              (1 diff-indicator-added-face)
                                              (2 'diff-added))
                                             ("\\(\\[-\\)\\(.+-\\]\\)"
                                              (1 diff-indicator-removed-face)
                                              (2 'diff-removed))
                                             ("^\\(?:Index\\|revno\\): \\(.+\\).*\n"
                                              (0 'diff-header)
                                              (1 'diff-index prepend))
                                             ("^\\(?:index .*\\.\\.\\|diff \\).*\n" . 'diff-header)
                                             ("^\\(?:new\\|deleted\\) file mode .*\n" . 'diff-header)
                                             ("^Only in .*\n" . 'diff-nonexistent)
                                             ("^Binary files .* differ\n" . 'diff-file-header)
                                             ("^\\(#\\)\\(.*\\)"
                                              (1 font-lock-comment-delimiter-face)
                                              (2 font-lock-comment-face))
                                             ("^diff: .*"
                                              (0 'diff-error))
                                             ("^[^-=+*!<>#].*\n"
                                              (0 'diff-context))
                                             (,#'diff--font-lock-syntax)
                                             (,#'diff--font-lock-prettify)
                                             (,#'diff--font-lock-refined)))))
