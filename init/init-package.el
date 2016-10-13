(require 'use-package)

(defvar my-ensured-packages
  '(
    use-package
    sublime-themes
    magit
    helm
    project-explorer
    projectile
    helm-projectile
    expand-region
    ace-jump-mode
    multiple-cursors
    ;;    auto-complete
    company
    company-statistics

    buffer-move
    yasnippet
    paredit

    web-mode
    js2-mode
    sass-mode
    jade-mode
    tide

    flycheck

    powershell ;; if on windows
    ))

(use-package sublime-themes
  :ensure t
  :demand
  :config
  (load-theme 'granger t))

(use-package magit
  :ensure t
  :bind (("C-o g" . magit-status)))

(use-package helm
  :ensure t
  :bind (("M-x" . helm-M-x)
         ("M-y" . helm-show-kill-ring)
         ("C-x b" . helm-mini)
         ("C-x C-f" . helm-find-files)
         ("C-x l" . helm-occur)
         ("C-x C-o" . project-explorer-helm)))

(use-package helm-projectile
  :ensure t
  :bind (("C-o s" . helm-projectile-switch-project))
  :config
  (progn (projectile-global-mode)
         (helm-projectile-on)))

(use-package project-explorer
  :ensure t
  :bind (("C-o e" . project-explorer-open))
  :commands (project-explorer-helm)
  :config
  (use-package projectile))

(use-package expand-region
  :ensure t
  :bind (("C-x =" . er/expand-region)))

(use-package ace-jump-mode
  :ensure t
  :bind (("C-x ?" . ace-jump-mode)))

(use-package multiple-cursors
  :ensure t
  :bind (("C-o n" . mc/mark-next-like-this)
         ("C-o p" . mc/mark-previous-like-this)
         ("C-o |" . mc/edit-lines)
         ("C-o a" . mc/mark-all-like-this)
         ("C-o r" . mc/set-rectangular-region-anchor)))

;; (use-package auto-complete
;;   :ensure t
;;   :config
;;   (global-auto-complete-mode))

(use-package company
  :ensure t
  :bind (("C-o SPC" . company-dabbrev-code))
  :config
  (progn (global-company-mode)
         (setq company-backends
               '((company-abbrev :seperate company-dabbrev)
                 (company-files
                  company-keywords
                  company-capf
                  company-yasnippet)))
         (add-hook 'lisp-interaction-mode-hook
                   (lambda()
                     (add-to-list (make-local-variable 'company-backends)
                                  'company-elisp)))
         (custom-set-variables
          '(company-dabbrev-minimum-length 2)
          '(company-minimum-prefix-length 2))))

(use-package company-statistics
  :ensure t
  :config
  (company-statistics-mode))

(use-package buffer-move
  :ensure t
  :bind (("<M-S-up>" . buf-move-up)
         ("<M-S-down>" . buf-move-down)
         ("<M-S-left>" . buf-move-left)
         ("<M-S-right>" . buf-move-right)))

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode t))

(use-package paredit
  :ensure t)

(use-package web-mode
  :ensure t
  :mode "\\.html?$")

(use-package sass-mode
  :ensure t
  :mode "\\.scss$")

(use-package js2-mode
  :ensure t
  :mode "\\.js$")

(use-package jade-mode
  :ensure t
  :mode "\\.jade$")

(use-package tide
  :ensure t
  :config
  (progn (add-hook 'typescript-mode-hook 'tide-setup)
         (add-hook 'js2-mode-hook 'tide-setup)
         (add-hook 'before-save-hook 'tide-format-before-save)))

(use-package flycheck
  :ensure t
  :config
  (progn (global-flycheck-mode)
         (setq-default flycheck-temp-prefix ".flycheck")
         (setq-default flycheck-emacs-lisp-load-path 'inherit)
         (setq-default flycheck-disabled-checkers
                       (append flycheck-disabled-checkers
                               '(emacs-lisp-checkdoc
                                 json-jsonlist
                                 javascript-jshint)))))

(when *is-win*
  (use-package powershell
    :ensure t
    :config
    (progn (add-to-list 'auto-mode-alist '("\\.psm1$" . powershell-mode))
           (add-to-list 'auto-mode-alist '("\\.ps1$" . powershell-mode)))))


;;; require package in MyEmacs/elisp
(use-package sys-utils
  :bind (("C-x C-s" . su/start-cmd)))

(use-package edit-utils
  :bind (("<M-up>" . eu/swap-line-up)
         ("<M-down>" . eu/swap-line-down)
         ("C-o h" . eu/collapse-around)))


(provide 'init-package)
