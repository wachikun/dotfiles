;;; -*- lexical-binding: t; -*-

;; compile のたび表示してほしくないので何もしない処理に
(defadvice tex-display-shell
    (around disable-display-buffer nil activate))
