(add-to-list 'load-path "~/.emacs.d/evernote-mode/")

     (require 'evernote-mode)
     (setq evernote-username "siddharth_bhal") ; optional: you can use this username as default.
     (setq evernote-enml-formatter-command '("w3m" "-dump" "-I" "UTF8" "-O" "UTF8")) ; option
(setq evernote-developer-token "S=s81:U=8a25ef:E=14a9984cafc:C=14341d39f00:P=1cd:A=en-devtoken:V=2:H=7c1a28dbd7a64ec1434d1a03ca437887")
     (global-set-key "\C-cec" 'evernote-create-note)
     (global-set-key "\C-ceo" 'evernote-open-note)
     (global-set-key "\C-ces" 'evernote-search-notes)
     (global-set-key "\C-ceS" 'evernote-do-saved-search)
     (global-set-key "\C-cew" 'evernote-write-note)
     (global-set-key "\C-cep" 'evernote-post-region)
     (global-set-key "\C-ceb" 'evernote-browser)

;; arch patch for coloring emacs shell 
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; infinality patch for emacs
(custom-set-faces
 '(default ((t (:family "Liberation Mono" :slant normal :weight regular :height 98))))
 '(variable-pitch ((t (:family "Liberation Sans" :slant normal :weight regular :height 98 )))))