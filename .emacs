;; Internationalization
(set-language-environment "Russian")
(set-terminal-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(tool-bar-mode 0)
(menu-bar-mode 0)
(winner-mode 1)
(linum-mode 1)
(column-number-mode 1)
(set-scroll-bar-mode nil)
(global-whitespace-mode t)
(setq whitespace-line-column 999)
(global-hi-lock-mode 1)
(show-paren-mode t)
(setq-default major-mode 'org-mode)
(setq whitespace-newline-mode nil)
;;(global-visual-line-mode t)
(setq inhibit-startup-screen t)
(setq initial-scratch-message "")

;; Initialize package
(package-initialize)

;; Dired
(setq dired-dwim-target t)
(put 'dired-find-alternate-file 'disabled nil)
(setq dired-listing-switches "-alh")

;; Dired+
(require 'dired+)

;; Backups/autosaves
(setq backup-inhibited t)
(setq auto-save-default nil)

;; Indentation
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq c-basic-offset 4)
(setq c-default-style "ellemtel"
      c-basic-offset 4)
(defun my-c-setup ()
   (c-set-offset 'innamespace [0]))
(add-hook 'c++-mode-hook 'my-c-setup)
(setq sgml-basic-offset 4)
(setq nxml-child-indent 4)
(setq lua-indent-level 4)

(setq which-func-mode t)

;; Windmove
(global-set-key (kbd "<up>") 'windmove-up)
(global-set-key (kbd "<down>") 'windmove-down)
(global-set-key (kbd "<right>") 'windmove-right)
(global-set-key (kbd "<left>") 'windmove-left)

;; test scale
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C-M-+") 'text-scale-decrease)

;; Autocompletion
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-20160310.2248/dict/")
(add-to-list 'ac-dictionary-directories "/usr/share/emacs/site-lisp/ac-dict")
(ac-config-default)
(ac-flyspell-workaround)

(require 'yasnippet)
(yas-global-mode 1)

(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers))
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

;; Scroll
;; (half page)
(defadvice scroll-up
    (around half-window activate)
  (setq next-screen-context-lines
        (max 1 (/ (1- (window-height (selected-window))) 2))) ad-do-it)
(defadvice scroll-down
    (around half-window activate)
  (setq next-screen-context-lines
        (max 1 (/ (1- (window-height (selected-window))) 2))) ad-do-it)

;; Mode autoload
(autoload 'php-mode "php-mode.el" "Php mode." t)
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)

;; web-mode
;;(require 'web-mode)

;; helm
(require 'helm-config)
(helm-mode 1)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-z")  'helm-select-action)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-c h o") 'helm-occur)
(global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)
(define-key minibuffer-local-map (kbd "C-c C-l") 'helm-minibuffer-history)
(setq helm-semantic-fuzzy-match t
      helm-imenu-fuzzy-match t
      helm-locate-fuzzy-match t
      helm-apropos-fuzzy-match t
      helm-M-x-fuzzy-match t
      helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match t
      helm-lisp-fuzzy-completion t)

;; helm-descbinds
(require 'helm-descbinds)
(helm-descbinds-mode)

;; helm-projectile
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(global-set-key (kbd "C-c p f") 'helm-projectile-find-file)
(global-set-key (kbd "C-c p d") 'helm-projectile-find-dir)


;; helm-grepint
(require 'helm-grepint)
(helm-grepint-set-default-config-latest)
(global-set-key (kbd "C-c g") #'helm-grepint-grep)
(global-set-key (kbd "C-c G") #'helm-grepint-grep-root)

;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
(setq flycheck-check-syntax-automatically '(mode-enabled save))

;; rainbow
;;(define-globalized-minor-mode global-rainbow-delimiters-mode rainbow-delimiters-mode
;;  (lambda () (rainbow-delimiters-mode 1)))
;;(global-rainbow-delimiters-mode 1)

;; expand-region
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; ggtags
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'php-mode 'php+-mode)
              (ggtags-mode 1)
              (setq ggtags-global-abbreviate-filename nil))))


;; Auto mode list
;; (add-to-list 'auto-mode-alist '("/.*\.phtml\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
;; TODO: use add-to-list
(setq auto-mode-alist (append '(("/.*\.php[345]?\'" . php-mode)) auto-mode-alist))
(setq auto-mode-alist (cons '("\.lua$" . lua-mode) auto-mode-alist))

(autoload 'geben "geben" "DBGp protocol frontend, a script debugger" t)
;; Debug a simple PHP script.
;; Change the session key my-php-54 to any session key text you like
(defun php-debug ()
  "Run current PHP script for debugging with geben"
  (interactive)
  (call-interactively 'geben)
  (shell-command
    (concat "XDEBUG_CONFIG='idekey=geben' /usr/bin/php "
    (buffer-file-name) " &"))
  )
(defun php-debug-args (args)
  "Run current PHP script for debugging with geben"
  (interactive "sScript arguments: ")
  (call-interactively 'geben)
  (shell-command
    (concat "XDEBUG_CONFIG='idekey=geben' /usr/bin/php "
    (buffer-file-name) " " args " &"))
  )
;; geben path mapping
(setq geben-path-mappings
      '(("/home/mngr/docker/projects/mittwald/src/magento2/" "/var/www/html")))
 

;; Add MELPA to package sources
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "https://marmalade-repo.org/packages/"))
;; use ony MELPA packages
;; (setq package-archives (list (cons "melpa" "http://melpa.org/packages/")))

;; Theme
;; (ample-theme)
;; (load-theme 'autumn-light t)
;; (load-theme 'zenburn)
;; (load-theme 'clues)
(load-theme 'arjen-grey t)



;; PHP
(add-hook 'php-mode-hook 'outline-minor-mode)
(add-hook 'php-mode-hook 'php-refactor-mode)
(add-hook 'php-mode-hook 'php-eldoc-enable)
(add-hook 'php-mode-hook
          '(lambda ()
             (c-set-style "psr2")))
(add-hook 'php-mode-user-hook
          '(lambda ()
             (outline-minor-mode)
             (setq outline-regexp " *\\(private funct\\|public funct\\|funct\\|class\\|#head\\)")
             (hide-sublevels 1)))

;; Speeding up Tramp
;; 1. Disable version control for tramp
(setq vc-ignore-dir-regexp
      (format "\\(%s\\)\\|\\(%s\\)"
              vc-ignore-dir-regexp
              tramp-file-name-regexp))
;; 2. Allow filename cache (assuming files can't change out of Emacs' control)
(setq remote-file-name-inhibit-cache nil)
;; 3. Disable directory update
(setq tramp-completion-reread-directory-timeout nil)

;; Auto
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(geben-visit-remote-file t)
 '(ggtags-global-abbreviate-filename 0)
 '(ggtags-update-on-save nil)
 '(package-selected-packages
   (quote
    (lua-mode bubbleberry-theme clues-theme basic-theme zenburn-theme autumn-light-theme arjen-grey-theme abyss-theme ample-zen-theme web-mode dired+ yaml-mode undo-tree f3 auto-complete geiser helm-proc helm-helm-commands helm-gtags ac-helm geben-helm-projectile php-eldoc php-extras php-scratch php-refactor-mode helm-grepint minimap php-mode rainbow-identifiers rainbow-delimiters flycheck helm-descbinds helm-projectile helm json-reformat session less-css-mode ggtags geben csv-mode auto-complete-c-headers ample-theme ac-php ac-html)))
 '(projectile-find-dir-includes-top-level t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "gray13" :foreground "#bdbdb3" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 126 :width normal :foundry "Bits" :family "Bitstream Vera Sans Mono"))))
 '(scroll-bar ((t (:background "gray11" :foreground "gray15"))))
 '(whitespace-empty ((t (:background "#202020" :foreground "#353535"))))
 '(whitespace-indentation ((t (:background "gray12" :foreground "#353535"))))
 '(whitespace-newline ((t (:foreground "#353535"))))
 '(whitespace-space ((t (:foreground "#353535"))))
 '(whitespace-trailing ((t (:background "#272727" :foreground "#444444" :weight bold)))))
(put 'downcase-region 'disabled nil)
(put 'set-goal-column 'disabled nil)
