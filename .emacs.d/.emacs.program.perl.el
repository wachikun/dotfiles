(defalias 'perl-mode 'cperl-mode)
(add-to-list 'auto-mode-alist
             '("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist
             '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist
             '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist
             '("miniperl" . cperl-mode))

(defun psh ()
  "psh"
  (interactive)
  (let ((bufname "*psh*"))
    (if (get-buffer bufname)
        (switch-to-buffer bufname)
      (setup-home-shell bufname " perl -ne 'print eval($_);print \"\n\";'\n"))))
