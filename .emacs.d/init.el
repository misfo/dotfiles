(when (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(starter-kit
                      starter-kit-bindings
                      starter-kit-lisp
                      starter-kit-ruby
                      starter-kit-js
                      evil
                      haml-mode
                      magit
                      nrepl
                      yaml-mode)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(setq-default show-trailing-whitespace t)

(require 'evil)
;; (evil-mode 1)
(add-hook 'find-file-hooks (lambda () (evil-local-mode nil)))

; Clojure
(add-to-list 'auto-mode-alist '("\\.dtm$" . clojure-mode))

; YAML
(autoload 'yaml-mode "yaml-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))
