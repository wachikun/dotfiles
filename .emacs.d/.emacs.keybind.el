;;; -*- lexical-binding: t; -*-

(global-set-key "\C-x~" 'shrink-window)
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\M-h" 'backward-kill-word)
(global-set-key "\C-l" 'only-recenter)
(global-set-key "\C-xO" (lambda () (interactive) (other-window -1)))

(global-unset-key "\C-\\")
(global-unset-key "\C-xt")
(global-unset-key "\C-xj")

                                        ; XEmacs compatible
(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-\C-l" 'switch-to-other-buffer)

                                        ; from XEmacs-21.5.5 files.el
(defun switch-to-other-buffer (arg)
  "Switch to the previous buffer.  With a numeric arg, n, switch to the nth
most recent buffer.  With an arg of 0, buries the current buffer at the
bottom of the buffer stack."
  (interactive "p")
  (if (eq arg 0)
      (bury-buffer (current-buffer)))
  (switch-to-buffer (if (<= arg 1)
                        (other-buffer (current-buffer))
                      (nth (1+ arg)
                           (buffer-list)))))

(defun reverse-other-window ()
  (interactive)
  (other-window -1))

(defun only-recenter ()
  (interactive)
  (recenter '(dummy)))
