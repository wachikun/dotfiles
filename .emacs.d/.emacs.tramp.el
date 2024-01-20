(require 'tramp)
(require 'tramp-sh)

(setq tramp-histfile-override "/dev/null")
(setq tramp-default-method "scp")
(nconc (car (cdr (assq 'tramp-login-args
                       (assoc "scp" tramp-methods))))
       '(("-c" "aes256-gcm@openssh.com")))

(add-to-list 'tramp-default-proxies-alist
             '(nil "\\`root\\'" "/ssh:%h:"))
(add-to-list 'tramp-default-proxies-alist
             '(nil "\\`nobody\\'" "/ssh:%h:"))
(add-to-list 'tramp-default-proxies-alist
             '("localhost" nil nil))
(add-to-list 'tramp-default-proxies-alist
             '((regexp-quote (system-name)) nil
               nil))
