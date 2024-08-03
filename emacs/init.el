(setq inhibit-startup-message t)

(scroll-bar-mode -1) 
(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1)

(set-fringe-mode 10)

(use-package doom-modeline
  :init (doom-modeline-mode 1))

(use-package doom-themes
  :init (load-theme 'doom-nord t))

(ivy-mode 1)
(global-display-line-numbers-mode 1)
(column-number-mode)
(global-display-fill-column-indicator-mode 1)
(electric-pair-mode t)

(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook
                ranger-mode-hook))
        (add-hook mode (lambda()
                       (display-line-numbers-mode 0)
                       (display-fill-column-indicator-mode 0))))

  ;           (dolist (mode '(org-mode-hook
  ;                           term-mode-hook
  ;                           shell-mode-hook
  ;                           eshell-mode-hook))
  ;             (add-hook mode (lambda() (setq global-hl-line-mode nil))))

(defun dmn/set-font-faces ()
(set-face-attribute 'default nil :font "RobotoMono Nerd Font" :height 115)
(set-face-attribute 'italic nil :font "RobotoMono Nerd Font" :slant 'italic :height 115)
(set-face-attribute 'fixed-pitch nil :font "RobotoMono Nerd Font" :height 115)
(set-face-attribute 'variable-pitch nil :font "Cantarell" :height 125 :weight 'regular))

(setq backup-by-copying t      ; don't clobber symlinks
    backup-directory-alist '(("." . "~/.saves"))    ; don't litter my fs tree
    delete-old-versions t
    kept-new-versions 6
    kept-old-versions 2
    version-control t)   

(setq auto-save-file-name-transforms
  `((".*" "~/.emacs-saves/" t)))

(custom-set-variables
 '(fill-column 80)
;;  '(display-fill-column-indicator-character "+")
)

(recentf-mode 1)
(setq recentf-max-saved-items 10)

(setq initial-major-mode 'org-mode)

(setq initial-scratch-message "")

(if (daemonp)
  (add-hook 'after-make-frame-functions
    (lambda (frame)
      (with-selected-frame frame
        (dmn/set-font-faces))))
  (dmn/set-font-faces))

(with-eval-after-load "flyspell"
  (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
  (define-key flyspell-mouse-map [mouse-3] #'undefined)
)

(with-eval-after-load "ispell"
  (setq ispell-program-name "hunspell")
  (setq ispell-dictionary "ru_RU,en_US")
    ;; ispell-set-spellchecker-params has to be called
    ;; before ispell-hunspell-add-multi-dic will work
  (ispell-set-spellchecker-params)
  (ispell-hunspell-add-multi-dic "ru_RU,en_US")
)

(require 'use-package)
(require 'package)

(setq package-archives '(
			  ("melpa" . "https://melpa.org/packages/")
			  ("org" . "https://orgmode.org/elpa/")
			  ("elpa" . "https://elpa.gnu.org/packages/")
			  )
      )

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents)
)

(setq use-package-always-ensure t)

;; better search
(use-package swiper)
;; just some icon fonts
(use-package all-the-icons)
;; pretty self explanatory
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))
;; better autocomplete in emacs command line
(use-package ivy-rich
  :init (ivy-rich-mode 1))
;; git integration
(use-package magit
  :custom (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))
;; better file managment
(use-package ranger
  :config (ranger-override-dired-mode t))
;; CSV
(use-package csv-mode)

(use-package ivy
  :diminish t
  :bind (
    ("C-f" . swiper)
    :map ivy-minibuffer-map
    ("TAB" . ivy-alt-done)
    ("C-j" . ivy-next-line)
    ("C-k" . ivy-previous-line)
    :map ivy-switch-buffer-map
    ("C-k" . ivy-previous-line)
    ("C-l" . ivy-done)
    ("C-d" . ivy-switch-buffer-kill)
    :map ivy-reverse-i-search-map
    ("C-k" . ivy-previous-line)
    ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package which-key
  :init (which-key-mode)
  :diminish (which-key-mode)
  :config
  (setq which-key-side-window-location (list 'left 'bottom))
  (setq which-key-idle-dely 0.2))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-switch-buffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil)) ;; dont start search

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] .  helpful-command)
  ([remap describe-variable] .  counsel-describe-variable)
  ([remap describe-key] .  helpful-key))

(use-package doc-view
  :config
    (define-key doc-view-mode-map (kbd "<f5>") 'revert-buffer-quick)
)

(defun kill-all-buffers ()
  "Kill all buffers"
  (interactive)
  (mapc 'kill-buffer (buffer-list)))

(use-package general
  :config
  (general-define-key ; set global keybinds
   "M-<tab>" 'counsel-switch-buffer)
  (general-define-key 
   "C-x K" 'magit-kill-this-buffer)
  (general-create-definer space/leader-keys
                          :keymaps '(normal insert visual emacs)
                          :prefix "SPC"
                          :global-prefix "M-SPC")
  (general-create-definer dap-keys
    :keymas '(normal visual emacs)
    :prefix "d"
  )
  ;; (general-evil setup t)
)

(use-package hydra)

(use-package evil
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-integrate t)
  (setq evil-want-C-u-scroll t)
;; (setq evil-want-C-i-jump nil)
;; :hook (evil-mode . rune/evil-hook)
  :config
  (evil-set-undo-system 'undo-redo)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-normal-state-map (kbd "C-f") 'swiper)
  (define-key evil-normal-state-map (kbd "/") 'swiper)
  (define-key evil-normal-state-map (kbd "C-w q") 'kill-buffer-and-window)
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-mode 1)
)
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package yasnippet
  :config (yas-global-mode))

(define-minor-mode evil/auto-layout-switch-mode
   "Minor mode for evil mode to make auto switch my kbd layout"
   nil
   :global t
   :lighter " auto switch layout"
   (defun activate()
     (add-hook 'evil-insert-state-entry-hook
               (lambda() (shell-command "hyprctl switchxkblayout keyd-virtual-keyboard 1")))
     (add-hook 'evil-insert-state-exit-hook
               (lambda() (shell-command "hyprctl switchxkblayout keyd-virtual-keyboard 0")))
     )

   (defun deactivate()
     (remove-hook 'evil-insert-state-entry-hook
               (lambda () (shell-command "hyprctl switchxkblayout keyd-virtual-keyboard 1")))
     (remove-hook 'evil-insert-state-exit-hook
               (lambda () (shell-command "hyprctl switchxkblayout keyd-virtual-keyboard 0")))
     )

   (if evil/auto-layout-switch-mode
   (activate)
   (deactivate))
   )

(define-key emacs-lisp-mode-map (kbd "<f5>") 'eval-buffer) ; set local (to each mode)

(defhydra hydra-text-scale (:timeout 3)
          "scale text"
          ("j" text-scale-increase "in")
          ("k" text-scale-decrease "out")
          ("f" nil "finished" :exit t))

(defhydra hydra-window-resize (:timeout 3)
  "resize emacs window"
  ("h" evil-window-decrease-width "decrease width")
  ("l" evil-window-increase-width "increase width")
  ("j" evil-window-decrease-height "decrease height")
  ("k" evil-window-increase-height "increase height")
  ("f" nil "finished" :exit t))

(space/leader-keys
  ;; "t" '(:ignore r :which-key "name") ;; for more complex keybinds
  "R" '(hydra-text-scale/body :which-key "scale text")
  "w" '(hydra-window-resize/body :which-key "resize window")
  "g" '(magit-status :which-key "magit")
  "SPC" '(evil/auto-layout-switch-mode :which-key "evil/auto-layout-switch-mode")
  "r" '(recentf-open-files :which-key "recent files")
)

(defun dw/org-mode-setup ()
  (setq org-fontify-quote-and-verse-blocks t)
  (variable-pitch-mode 1)
  (visual-line-mode 1)
  (org-indent-mode)
  (flyspell-mode 1)
;;   (guess-language-mode 1)
)

(use-package org
  :hook ( org-mode . dw/org-mode-setup)
  :config
  (setq org-ellipsis " ⌄")
  (setq org-hide-emphasis-markers t)
  (setq org-agenda-files '("~/Documents/Agenda.org"))
  (setq org-support-shift-select t)
  )

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
)

(with-eval-after-load 'org-faces
(dolist (face '((org-level-1 . 1.3)
		(org-level-2 . 1.2)
		(org-level-3 . 1.1)
		(org-level-4 . 1.05)
		(org-level-5 . 1.1)
		(org-level-6 . 1.1)
		(org-level-7 . 1.1)
		(org-level-8 . 1.1)))
(set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face))))

(with-eval-after-load 'org-faces
(set-face-attribute 'org-block nil :inherit '(fixed-pitch))
(set-face-attribute 'org-table nil :inherit '(fixed-pitch))
(set-face-attribute 'org-code nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-special-keyword nil :inherit '(font-lock-coment-face fixed-pitch))
(set-face-attribute 'org-meta-line nil :inherit '(font-lock-coment-face fixed-pitch))
(set-face-attribute 'org-checkbox nil :inherit '(org-todo fixed-pitch))
(set-face-attribute 'org-quote nil :font "Times New Roman" :slant 'normal :weight 'regular)
;; (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
)

(defun org/mode-visual-fill ()
  (setq visual-fill-column-width 125
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . org/mode-visual-fill))

(org-babel-do-load-languages
  'org-babel-load-languages
  '((emacs-lisp . t)
    (python . t)
    (gnuplot . t)))

(setq org-confirm-babel-evaluate nil)

(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))

(use-package projectile
  :demand
  :init
  (projectile-mode 1)
  :diminish projectile-mode
  :config
  (define-key projectile-command-map (kbd "K")
    '("kill-buffers-no-confirm" . (lambda () (interactive) (project-kill-buffers t))))
   (setq projectile-switch-project-action 'counsel-projectile)
  :bind
  (:map evil-insert-state-map
    ("M-SPC p" . projectile-command-map))
  (:map evil-normal-state-map
    ("SPC p" . projectile-command-map))
  (:map evil-normal-state-map
    ("M-SPC p" . projectile-command-map))
)

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package project
  :ensure t
  :config
  (define-key project-prefix-map (kbd "K")
    '("kill-buffers-no-confirm" . (lambda () (interactive) (project-kill-buffers t))))
  :bind
 ;;  (:map global-map
 ;;    ("M-SPC p" . projectile-command-map))
 ;; (:map evil-normal-state-map
 ;;   ("SPC p" . projectile-command-map))
)

(use-package lsp-mode
:init
;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
(setq lsp-keymap-prefix "C-l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
       ;; if you want which-key integration
       (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;; optionally
(use-package lsp-ui :commands lsp-ui-mode)
;; if you are ivy user
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)

;; optionally if you want to use debugger
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

(use-package company
  :hook (lsp-mode . company-mode)
  :config
  (setq lsp-completion-provider :capf)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
)

(use-package flycheck)

(use-package dap-mode)

(use-package python-mode
  :ensure t
  :hook
  (python-mode . lsp-deferred) ;; for LSP support
  (python-mode . (lambda() (outline-minor-mode 1)))
  (python-mode . (lambda() (hl-line-mode 1)))
  :custom
  (python-shell-interpreter "python")
  :config
  (setq python-indent-offset 4)
  (require 'dap-python)
  (setq dap-python-debugger 'debugpy)
  :init
  (outline-minor-mode 1)
)
;; (use-package dap-python)

(require 'dap-dlv-go)
(use-package go-mode
  :ensure t
  :hook
  (go-mode . lsp-deferred)
  (go-mode . (lambda() (hs-minor-mode 1)))
  (go-mode . (lambda() (hl-line-mode 1)))
  (go-mode . (lambda() (setq tab-width 4)))
;;   (go-mode . (lambda() ()))
)

(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook
  (typescript-mode . lsp-deferred)
  (typescript-mode . (lambda() (hl-line-mode 1)))

  :config (setq typescript-indent-level 4))

(use-package fish-mode
  :hook
  (fish-mode . (lambda() (hl-line-mode 1)))
)

(use-package auctex
  :defer t
  :hook
    (LaTeX-mode . (lambda() (push (list 'output-pdf "Zathura") TeX-view-program-selection)))
    (LaTeX-mode . (lambda() (outline-minor-mode 1)))
    (LaTeX-mode . (lambda() (flyspell-mode 1)))
    (LaTeX-mode . (lambda() (hl-line-mode 1)))
;;     (LaTeX-mode . (lambda()
;;       ((add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t)))
;;       (setq TeX-command-default "XeLaTeX")
;;       (setq TeX-save-query nil)))
)

(add-hook 'LaTeX-mode-hook 
        (lambda()
           (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
           (setq TeX-command-default "XeLaTeX")
           (setq TeX-save-query nil)))

(use-package csharp-mode
  :ensure t
  :hook
  (csharp-mode . lsp-deferred)
  (csharp-mode . (lambda() (hs-minor-mode 1)))
  (csharp-mode . (lambda() (setq tab-width 4)))
  (csharp-mode . (lambda() (hl-line-mode 1)))
)

(use-package lua-mode
  :hook
  (lua-mode . (lambda() (hl-line-mode 1)))
)
