(setq user-full-name "Siddharth Bhal")
(setq user-mail-address "sidd.bhal@gmail.com")

;;(load-theme 'wombat t)
(global-set-key (kbd "C-c a") 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files (list "/local/mnt/workspace/sbhal/Dropbox/org"))

;;(add-to-list 'load-path "~/.emacs.d/evernote-mode/")

;;(setq evernote-developer-token "S=s81:U=8a25ef:E=14a9984cafc:C=14341d39f00:P=1cd:A=en-devtoken:V=2:H=7c1a28dbd7a64ec1434d1a03ca437887")

;; arch patch for coloring emacs shell 
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; infinality patch for emacs
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Liberation Mono" :slant normal :weight regular :height 98))))
 '(variable-pitch ((t (:family "Liberation Sans" :slant normal :weight regular :height 98)))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(global-linum-mode t)
 '(global-visual-line-mode t)
 '(ido-mode (quote both) nil (ido)))

(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

;; .tut and .req files will open with text-mode as major mode
(setq auto-mode-alist
      (append
       '(("\\.tut$" . text-mode)
	 ("\\.req$" . text-mode))
       auto-mode-alist))

;; settings applied permode basis using hook, spaces for tabs
(add-hook 'text-mode-hook (lambda() (setq indent-tabs-mode nil)))

;; define key defines key for particular mode
(define-key text-mode-map (kbd "<f8>") 'delete-trailing-whitespace)

;; global key define key for all modes
(global-set-key (kbd "<f7>") 'query-replace-regexp)

;; (ido-mode 1)
;; (setq ido-enable-flex-matching t)
;; (setq ido-everywhere  t)
;; (setq ido-use-virtual-buffers t)

(setq inhibit-startup-message t
inhibit-startup-echo-area-message t)

(setq column-number-mode t)

;; get rid of `find-file-read-only' and replace it with something
;; more useful.
(global-set-key (kbd "C-x C-r") 'ido-recentf-open)
 
;; enable recent files mode.
(recentf-mode t)
 
; 50 files ought to be enough.
(setq recentf-max-saved-items 50)
 
(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))


(fset 'yes-or-no-p 'y-or-n-p)
(setq confirm-nonexistent-file-or-buffer nil)

;; deft
(add-to-list 'load-path "~/.emacs.d/vendor/deft")
(require 'deft)
(setq deft-extension "org")
(setq deft-directory "/local/mnt/workspace/sbhal/Dropbox/org")
(setq deft-text-mode 'org-mode)
(setq deft-use-filename-as-title t)
(define-minor-mode deft-note-mode "Deft notes" nil " Deft-Notes" nil)
(setq deft-text-mode 'deft-note-mode)
(defun kill-all-deft-notes ()
  (interactive)
  (save-excursion
    (let((count 0))
      (dolist(buffer (buffer-list))
        (set-buffer buffer)
        (when (not (eq nil deft-note-mode))  
          (setq count (1+ count))
          (kill-buffer buffer)))
      )))
(defun deft-or-close () (interactive) (if (or (eq major-mode 'deft-mode) (not (eq nil deft-note-mode)))
                                          (progn (kill-all-deft-notes) (kill-buffer "*Deft*"))
                                        (deft)
                                        ))
(global-set-key [f6] 'deft-or-close)


;;flyspell spelling checker
;;(setq flyspell-issue-welcome-flag nil)
;;(setq-default ispell-program-name "/usr/local/bin/aspell")
;;(setq-default ispell-list-command "list")

(setq backup-directory-alist `(("." . "~/tmp/emacs")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)
(add-to-list 'load-path "~/.emacs.d/vendor")
(require 'smex) ; Not needed if you use package.el
;;(smex-initialize) ; Can be omitted. This might cause a (minimal) delay
                  ; when Smex is auto-initialized on its first run.

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(setq echo-keystrokes 0.1
      use-dialog-box nil
      visible-bell t)
(show-paren-mode t)

;;(require 'package)
;;(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
;;                         ("marmalade" . "http://marmalade-repo.org/packages/")
;;                         ("melpa" . "http://melpa.milkbox.net/packages/")))
;; "Devanagari"  U+0900 - U+1097F
;;    (set-fontset-font "fontset-default"
;;                      (cons (decode-char 'ucs #x0900)
;;                            (decode-char 'ucs #x097f))
;;                      "Siddhanta")
;; Siddhanta could be replaced by Lohit Devanagari
;; fonts are placed in ~/.fonts, fc-cache ~/.fonts/ , check by fc-list
;; "Devanagari Extended"  U+A8E0 - U+A8FF
;;    (set-fontset-font "fontset-default"
;;                      (cons (decode-char 'ucs #xa8e0)
;;                            (decode-char 'ucs #xa8ff))
;;                      "Siddhanta")
;; "Vedic Extensions" (Devanagari) U+1CD0 - U+1CFF
;;    (set-fontset-font "fontset-default"
;;                      (cons (decode-char 'ucs #x1cd0)
;;                            (decode-char 'ucs #x1cff))
;;                      "Siddhanta")

;; x11 windows copy paste clipboard
 (setq x-select-enable-clipboard t)
