;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)

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
    color-theme-sanityinc-tomorrow))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

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
(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'material t) ;; load material theme
;;(load-theme 'zenburn t) ;; load material theme
;;(load-theme 'color-theme-sanityinc-tomorrow-night t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally
(add-to-list 'default-frame-alist '(fullscreen . fullheight)) ;; maximize height
(add-to-list 'default-frame-alist (cons 'width 120)) ;; window width to 120 chars
(setq column-number-mode t) ;; show column number
(setq-default indent-tabs-mode nil) ;; disable tabs

; Highlight tabs and trailing whitespace everywhere
(setq whitespace-style '(face trailing tabs))
(custom-set-faces
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


;; C/C++ Mode
;;

; start flymake-google-cpplint-load
; let's define a function for flymake initialization
(defun my:flymake-google-init () 
  (require 'flymake-google-cpplint)
  ;;(custom-set-variables
  ;; '(flymake-google-cpplint-command "/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin/cpplint"))
  (flymake-google-cpplint-load)
)
(add-hook 'c-mode-hook 'my:flymake-google-init)
(add-hook 'c++-mode-hook 'my:flymake-google-init)

; start yasnippet with emacs
(require 'yasnippet)
(yas-global-mode 1)

; start google-c-style with emacs
(require 'google-c-style)
;;(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(custom-set-variables
 '(tab-width 4))
;;(setq-default c-basic-offset 4)
;;(setq-default tab-width 4) ; or any other preferred value
;;(defvaralias 'c-basic-offset 'tab-width)

(setq tab-width 4) ; or any other preferred value
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

(setq-default tab-width 4)

