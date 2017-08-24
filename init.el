 ;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------

;; Start server only if it is not running.
(load "server")
(unless (server-running-p) (server-start))

;; Reload buffer without confirmation
;; Source: http://www.emacswiki.org/emacs-en/download/misc-cmds.el
(defun revert-buffer-no-confirm ()
    "Revert buffer without confirmation."
    (interactive)
    (revert-buffer :ignore-auto :noconfirm))

(require 'package)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    elpy
    flycheck
    py-autopep8
    material-theme
    zenburn-theme
    color-theme-sanityinc-tomorrow
    google-c-style
    jedi
    iedit
    flymake-google-cpplint
    flymake-cursor
    auto-complete
    auto-complete-c-headers
    yasnippet
    cedet))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

(require 'auto-complete)

(require 'auto-complete-config)
(ac-config-default)

(require 'iedit)

(elpy-enable)

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)


;; BASIC CUSTOMIZATION
;; --------------------------------------

(require 'color-theme-sanityinc-tomorrow)

(menu-bar-mode -1) ;; hide menu bar
(tool-bar-mode -1) ;; hide tool bar
(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'material t) ;; load material theme
;;(load-theme 'zenburn t) ;; load material theme
;;(load-theme 'color-theme-sanityinc-tomorrow-night t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally
(add-to-list 'default-frame-alist '(fullscreen . fullheight)) ;; maximize height
(add-to-list 'default-frame-alist (cons 'width 120)) ;; window width to 120 chars
(setq column-number-mode t) ;; show column number
(setq-default indent-tabs-mode nil) ;; disable tabs
(setq-default python-indent-guess-indent-offset nil) ;; disable python indent guess

; Highlight tabs and trailing whitespace everywhere
(setq whitespace-style '(face trailing tabs))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(whitespace-tab ((t (:background "red")))))
(global-whitespace-mode)


;; Fonts
;; 

;;(set-default-font "Inconsolata 11")
;;(set-default-font "FiraCode 11")
;;(set-default-font "RobotoMono 11") 
;;(set-default-font "Roboto Medium 11")
;;(set-default-font "Roboto Bold 11")
;;(set-default-font "Roboto Bold Condensed 11")
(set-default-font "Monaco 11")
;;(set-default-font "Dejavu Sans Mono 9")
;; init.el ends here


(semantic-mode 1)

;; C/C++ Mode
;;

; start flymake-google-cpplint-load
; let's define a function for flymake initialization
(defun my:flymake-google-init () 
  (require 'flymake-google-cpplint)
  (custom-set-variables
   '(flymake-google-cpplint-command "/usr/local/bin/cpplint"))
  (flymake-google-cpplint-load)
)
(add-hook 'c-mode-hook 'my:flymake-google-init)
(add-hook 'c++-mode-hook 'my:flymake-google-init)

(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (setq achead:include-directories
        (append '("/usr/include/c++/5"
                  "/usr/include/x86_64-linux-gnu/c++/5"
                  "/usr/include/c++/5/backward"
                  "/usr/lib/gcc/x86_64-linux-gnu/5/include"
                  "/usr/local/include"
                  "/usr/lib/gcc/x86_64-linux-gnu/5/include-fixed"
                  "/usr/include/x86_64-linux-gnu"
                  "/usr/include")
                achead:include-directories)))

(add-hook 'c-mode-hook 'my:ac-c-header-init)
(add-hook 'c++-mode-hook 'my:ac-c-header-init)

(defun my:add-semantic-to-autocomplete ()
  (add-to-list 'ac-sources 'ac-source-semantic))

(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)
(add-hook 'c++-mode-common-hook 'my:add-semantic-to-autocomplete)

(global-ede-mode 1)

(ede-cpp-root-project "my project" :file "~/dev/test.cpp"
                      :include-path '("~dev/"))

(global-semantic-idle-scheduler-mode 1)

; start yasnippet with emacs
(require 'yasnippet)
(yas-global-mode 1)

; start google-c-style with emacs
(require 'google-c-style)
(defun my-c-mode-hook ()
  (google-set-c-style)
  (setq c-basic-offset 4 
        ;;indent-tabs-mode t 
        default-tab-width 4))

(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)

;;(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("59064d8bde39b9f4c663e319eba863c9518194d6ff77dbc582b2150d07b5a908" default)))
 '(tool-bar-mode nil))


;;(custom-set-variables
;; '(tab-width 4))
;;(setq-default c-basic-offset 4)
;;(setq-default tab-width 4) ; or any other preferred value
;;(defvaralias 'c-basic-offset 'tab-width)

;;(setq tab-width 4) ; or any other preferred value
;;(defvaralias 'c-basic-offset 'tab-width)
;;(defvaralias 'cperl-indent-level 'tab-width)
;;(defvaralias 'cperl-indent-level 'tab-width)

(setq-default tab-width 4)

(setq-default c-basic-offset 4)

