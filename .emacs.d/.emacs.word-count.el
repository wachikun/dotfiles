;;; -*- lexical-binding: t; -*-

(autoload 'word-count-mode "word-count" "Minor mode to count words."
  t nil)
(add-hook 'word-count-mode-hook
          (lambda ()
            (let ((alist (assq 'latex-mode word-count-preremove-regexp-alist)))
              (setcdr alist
                      (cons "\\\\[][\.-\.---a-zA-Z0-9{}, =]+" (cdr alist))))))
