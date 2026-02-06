;;; -*- lexical-binding: t; -*-

(require 'migemo)

(setq migemo-command (expand-file-name "~/local/cmigemo/bin/cmigemo"))
(setq migemo-options '("--quiet" "--emacs" "-i" "\g"))
(setq migemo-dictionary (expand-file-name "~/local/cmigemo/share/migemo/utf-8/migemo-dict"))
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)
(setq migemo-pattern-alist-length 10000)

(migemo-init)
