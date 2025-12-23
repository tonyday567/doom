;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; other configuration examples
;;

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Tony Day"
      user-mail-address "tonyday567@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;    presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;;(setq doom-font (font-spec :family "Iosevka ss02" :size 14 :weight 'light)
;;      doom-variable-pitch-font (font-spec :family "Iosevka etoile" :size 14))
;;(setq doom-font (font-spec :family "Victor Mono")
;;      doom-variable-pitch-font (font-spec :family "Iosevka Aile"))

(setq doom-font (font-spec :family "Victor Mono"))
(setq doom-variable-pitch-font (font-spec :family "Iosevka Aile"))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-Iosvkem)
;; (setq doom-theme 'modus-vivendi)
(setq doom-theme 'ef-bio)
;; (doom-themes-org-config)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(use-package! ef-themes
  :config
  (setq ef-themes-to-toggle '(ef-bio ef-dark))
  (map! :leader "te" #'ef-themes-toggle)
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme 'ef-bio t))

(setq confirm-kill-emacs nil
      confirm-kill-processes nil)

;; setq-default sets variables that are usually local to buffers
(setq-default truncate-lines nil
              indent-tabs-mode nil)

(map! ;; removes from kill ring
      [remap backward-kill-word] #'doom/delete-backward-word
      ;; replaces just-one-space
      "M-SPC" #'cycle-spacing
      [remap ibuffer] #'ibuffer-jump)

(setq doom-modeline-lsp-icon nil)
(setq doom-modeline-buffer-encoding nil)
(setq doom-modeline-buffer-state-icon nil)
(setq doom-modeline-vcs-max-length 8)
(setq doom-modeline-lsp nil)
(setq doom-modeline-modal nil)

(defun style/left-frame ()
  (interactive)
  (cond
   ((string-equal system-type "windows-nt") ; Microsoft Windows
    (progn
      (set-frame-parameter (selected-frame) 'fullscreen nil)
      (set-frame-parameter (selected-frame) 'vertical-scroll-bars nil)
      (set-frame-parameter (selected-frame) 'horizontal-scroll-bars nil)
      (set-frame-parameter (selected-frame) 'top 10)
      (set-frame-parameter (selected-frame) 'left 6)
      (set-frame-parameter (selected-frame) 'height 40)
      (set-frame-parameter (selected-frame) 'width 120)))
   ((string-equal system-type "darwin") ; Mac OS X
    (progn
      (set-frame-parameter (selected-frame) 'fullscreen nil)
      (set-frame-parameter (selected-frame) 'vertical-scroll-bars nil)
      (set-frame-parameter (selected-frame) 'horizontal-scroll-bars nil)
      (set-frame-parameter (selected-frame) 'top 23)
      (set-frame-parameter (selected-frame) 'left 0)
      (set-frame-parameter (selected-frame) 'height 44)
      (set-frame-parameter (selected-frame) 'width 100)
      (message "default-frame set")))
   ((string-equal system-type "gnu/linux") ; linux
    (progn
      (message "Linux")))))

(add-to-list 'initial-frame-alist '(top . 23))
(add-to-list 'initial-frame-alist '(left . 0))
(add-to-list 'initial-frame-alist '(height . 44))
(add-to-list 'initial-frame-alist '(width . 100))

(defun style/max-frame ()
  (interactive)
  (if t
      (progn
        (set-frame-parameter (selected-frame) 'fullscreen 'fullboth)
        (set-frame-parameter (selected-frame) 'vertical-scroll-bars nil)
        (set-frame-parameter (selected-frame) 'horizontal-scroll-bars nil))
    (set-frame-parameter (selected-frame) 'top 26)
    (set-frame-parameter (selected-frame) 'left 2)
    (set-frame-parameter (selected-frame) 'width
                         (floor (/ (float (x-display-pixel-width)) 9.15)))
    (if (= 1050 (x-display-pixel-height))
        (set-frame-parameter (selected-frame) 'height
                             (if (>= emacs-major-version 24)
                                 66
                               55))
      (set-frame-parameter (selected-frame) 'height
                           (if (>= emacs-major-version 24)
                               75
                             64)))))

(style/left-frame)  ;; Focus new window after splitting
(map!
   :leader
   :nvm "tm" #'style/max-frame
   :nvm "td" #'style/left-frame)

(map!
 (:map 'override
   :v "v" #'er/expand-region
   :v "V" #'er/contract-region))
(map!
 (:map 'override
   :m "j" #'evil-next-visual-line
   :m "k" #'evil-previous-visual-line))

(setq evil-kill-on-visual-paste nil
      evil-move-cursor-back nil
      evil-move-beyond-eol t
      evil-highlight-closing-paren-at-point-states nil)

(defun evil-forward-after-end (thing &optional count)
  "Move forward to end of THING.
The motion is repeated COUNT times."
  (setq count (or count 1))
  (cond
   ((> count 0)
    (forward-thing thing count))
   (t
    (unless (bobp) (forward-char -1))
    (let ((bnd (bounds-of-thing-at-point thing))
          rest)
      (when bnd
        (cond
         ((< (point) (cdr bnd)) (goto-char (car bnd)))
         ((= (point) (cdr bnd)) (cl-incf count))))
      (condition-case nil
          (when (zerop
                 (setq rest
                       (forward-thing thing count)))
            (end-of-thing thing))
        (error))
      rest))))

(evil-define-motion evil-forward-after-word-end (count &optional bigword)
  "Move the cursor to the end of the COUNT-th next word.
If BIGWORD is non-nil, move by WORDS."
  :type inclusive
  (let ((thing (if bigword 'evil-WORD 'evil-word))
        (count (or count 1)))
    (evil-signal-at-bob-or-eob count)
    (evil-forward-after-end thing count)))

(evil-define-motion evil-forward-after-WORD-end (count)
  "Move the cursor to the end of the COUNT-th next WORD."
  :type inclusive
  (evil-forward-after-word-end count t))

(map!
 :m "e" 'evil-forward-after-word-end
 :m "E" 'evil-forward-after-WORD-end)

(after! evil-escape
  (setq evil-escape-key-sequence "jk")
  (setq evil-escape-delay 0.2)
  (evil-escape-mode 1))

(remove-hook 'text-mode-hook #'spell-fu-mode)
;;(setq spell-fu-ignore-modes (list 'org-mode))

(setq vertico-sort-function #'vertico-sort-history-alpha)

(define-key isearch-mode-map (kbd "M-j") 'avy-isearch)

(defun isearch-forward-other-window (prefix)
    "Function to isearch-forward in other-window."
    (interactive "P")
    (unless (one-window-p)
      (save-excursion
        (let ((next (if prefix -1 1)))
          (other-window next)
          (isearch-forward)
          (other-window (- next))))))

(defun isearch-backward-other-window (prefix)
  "Function to isearch-backward in other-window."
  (interactive "P")
  (unless (one-window-p)
    (save-excursion
      (let ((next (if prefix 1 -1)))
        (other-window next)
        (isearch-backward)
        (other-window (- next))))))

(define-key global-map (kbd "C-r") 'isearch-backward)
(define-key global-map (kbd "C-M-s") 'isearch-forward-other-window)
(define-key global-map (kbd "C-M-r") 'isearch-backward-other-window)
(define-key global-map (kbd "M-s-s") 'isearch-forward-regexp)
(define-key global-map (kbd "M-s-r") 'isearch-backward-regexp)

(map!
 (:map 'override
   :nvm "gss" #'evil-avy-goto-char-timer
   :nvm "gs/" #'evil-avy-goto-char-2))

(use-package! avy
 :config
 (setq avy-all-windows t)
)

(defun avy-action-embark (pt)
  (unwind-protect
      (save-excursion
        (goto-char pt)
        (embark-act))
    (select-window
     (cdr (ring-ref avy-ring 0))))
  t)

(setf (alist-get ?. avy-dispatch-alist) 'avy-action-embark)

(map!
   :leader "w w" #'ace-window)

(map!
   :leader "s f" #'consult-find
   :leader :desc "consult-outline" "s o" #'consult-outline
   :leader "b o" #'consult-buffer-other-window
   :leader "s y" #'consult-yank-from-kill-ring
   :leader "r l" #'consult-register-load
   :leader "r s" #'consult-register-store
   :leader "r r" #'consult-register
   [remap jump-to-register] #'consult-register-load)

(use-package orderless
  :init
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles . (partial-completion))))))

(after! latex
 (setq org-latex-packages-alist '(("" "tikz-cd" t) ("" "tikz" t)))
)

(after! flycheck
  (map!
    :n "M-n" 'flycheck-next-error
    :n "M-p" 'flycheck-previous-error))

(after! company
  :config
  (setq +company-backend-alist (assq-delete-all 'prog-mode +company-backend-alist))
  (add-to-list '+company-backend-alist '(prog-mode (company-dabbrev-code :separate company-capf)))
  (map! :leader "ti" #'toggle-company-ispell))

(after! haskell-ng-mode
    (set-company-backend! 'haskell-ng-mode nil)
    (set-company-backend! 'haskell-ng-mode '(company-capf)))

(defun toggle-company-ispell ()
  "Toggle company ispell backend."
  (interactive)
  (cond
   ((memq 'company-ispell company-backends)
    (setq company-backends (delete 'company-ispell company-backends))
    (message "company-ispell disabled"))
   (t
    (push 'company-ispell company-backends)
    (message "company-ispell enabled!"))))

(use-package! dashboard
  :config
    (setq dashboard-items
      '((recents  . 5)
        (agenda . 10)
        (projects . 5)
        (bookmarks . 5)))
    (setq dashboard-banner-logo-title "welcome, Sir, to Cyprus. -- Goats and Monkeys!")
    ;(setq dashboard-display-icons-p t)
    ;(setq dashboard-icon-type 'nerd-icons)
    (setq dashboard-set-navigator t)
    (setq dashboard-startup-banner 'logo)
    (setq dashboard-set-footer nil)
    (setq dashboard-item-shortcuts '((recents . "r") (bookmarks . "m") (projects . "p") (agenda . "a") (registers . "e")))
    (setq dashboard-filter-agenda-entry 'dashboard-no-filter-agenda)
    (setq dashboard-agenda-prefix-format "%s%-12:c")
    ;(setq dashboard-agenda-sort-strategy '(todo-state-up))
    (setq dashboard-item-names '(("Recent Files:" . "Recent:")
                                 ("Agenda for the coming week:" . "Next:")))
    (setq dashboard-match-agenda-entry "+TODO=\"Next\"|SCHEDULED<\"<now>\"")
    ;(setq dashboard-set-heading-icons t)
    ;(setq dashboard-set-file-icons t)
    (map! :leader "ox" #'dashboard-open)
    (dashboard-setup-startup-hook))

(after! org
  :config
  (setq
   org-log-into-drawer t
   org-startup-folded t
   org-support-shift-select t
   org-insert-heading-respect-content t
   org-startup-with-inline-images t
   org-cycle-include-plain-lists 'integrate
   ;; https://github.com/syl20bnr/spacemacs/issues/13465
   org-src-tab-acts-natively nil
   ;; from org-modern example
   org-auto-align-tags nil
   org-tags-column 0
   org-fold-catch-invisible-edits 'show-and-error
   org-special-ctrl-a/e t
   org-hide-emphasis-markers t
   org-pretty-entities t
   org-ellipsis "…"
   org-agenda-tags-column 0
   org-agenda-block-separator ?─
   org-export-with-toc nil
   org-export-use-babel nil)
   (remove-hook 'org-mode-hook 'flyspell-mode)
   (setq-default org-todo-keywords '((sequence "ToDo(t)" "Next(n)" "Blocked(b)" "|" "Done(d)")))
)

(after! org-agenda
  :config
  (setq org-agenda-span 'week
        org-agenda-use-time-grid nil
        org-agenda-start-day "-0d"
        org-agenda-block-separator nil
        org-agenda-skip-scheduled-if-done t
        org-agenda-inhibit-startup nil
        org-agenda-show-future-repeats nil
        org-agenda-compact-blocks t
        org-agenda-window-setup 'other-window
        org-agenda-show-all-dates nil
        org-agenda-prefix-format
         '((agenda . " %-24t")
           (todo . " %-24(org-name-short)")))
  (setq org-agenda-custom-commands
         '(("n" "next"
            ((agenda "" ((org-agenda-overriding-header "")))
             (todo "Next" ((org-agenda-overriding-header "Next")))))
           ("z" "z-agenda"
            ((agenda "" ((org-agenda-overriding-header "")))
             (todo "Next" ((org-agenda-overriding-header "Next")))
             (todo "Blocked" ((org-agenda-overriding-header "Blocked")))
             (todo "ToDo" ((org-agenda-overriding-header "ToDo")))))))
  (map! :leader "oz" #'agenda-z))

(defun org-name-short ()
  (interactive)
  (let
      ((xs (seq-subseq (file-name-split (buffer-file-name)) -2)))
      (concat
      (concat (nth 0 xs) "/")
      (file-name-base
      (nth 1 xs)))))

(defun agenda-z ()
  (interactive)
  (org-agenda nil "z"))

(after! org
  (setq
   org-capture-templates
   (quote
    (("r" "refile" entry
      (file "~/org/refile.org")
      "* ToDo %?
")
     ("z" "bugz" entry
      (file+headline "~/org/bugz.org" "bugz!")
      "* ToDo %?
%a")))))

(after! org
  :config
  (progn
    (set-company-backend! 'org-mode nil)
    (set-company-backend! 'org-mode '(:separate company-yasnippet company-dabbrev))))

(after! org
  :config
  (defun display-ansi-colors ()
    (interactive)
    (let ((inhibit-read-only t))
      (ansi-color-apply-on-region (point-min) (point-max))))
   (add-hook 'org-babel-after-execute-hook #'display-ansi-colors)

   (map! :map org-mode-map
         :localleader
         (:prefix ("z" . "yank to block")
          :nvm "b" #'org-yank-into-new-block
          :nvm "e" #'org-yank-into-new-block-elisp
          :nvm "s" #'org-yank-into-new-block-sh
          :nvm "h" #'org-yank-into-new-block-haskell
          :nvm "n" #'org-new-block-haskell
          :nvm "z" (cmd! (org-new-block ""))
          :nvm "q" #'org-yank-into-new-quote)))

(defun org-yank-into-new-block (&optional template)
    (interactive)
    (let ((begin (point))
          done)
      (unwind-protect
          (progn
            (end-of-line)
            (yank)
            (push-mark begin)
            (setq mark-active t)
            (if template
             (org-insert-structure-template template)
             (call-interactively #'org-insert-structure-template))
            (setq done t)
            (deactivate-mark)
            (let ((case-fold-search t))
              (re-search-forward (rx bol "#+END_")))
            (forward-line 1))
        (unless done
          (deactivate-mark)
          (delete-region begin (point))))))

(defun org-new-block (&optional template)
    (interactive)
    (let ((begin (point))
          done)
      (unwind-protect
          (progn
            (end-of-line)
            (push-mark begin)
            (setq mark-active t)
            (if template
             (org-insert-structure-template template)
             (call-interactively #'org-insert-structure-template))
            (setq done t)
            (deactivate-mark)
            (evil-org-open-above 1))
        (unless done
          (deactivate-mark)
          (delete-region begin (point))))))

(defun org-yank-into-new-block-elisp ()
  (interactive)
  (org-yank-into-new-block "src elisp"))

(defun org-yank-into-new-block-sh ()
  (interactive)
  (org-yank-into-new-block "src sh :results output"))

(defun org-yank-into-new-block-haskell ()
  (interactive)
  (org-yank-into-new-block "src haskell-ng :results output"))

(defun org-new-block-haskell ()
  (interactive)
  (org-new-block "src haskell-ng :results output"))

(defun org-yank-into-new-quote ()
  (interactive)
  (org-yank-into-new-block "quote"))

(after! org
  (use-package! org-random-todo
    :defer-incrementally t
    :commands (org-random-todo-goto-new)
    :config
    (map! :map org-mode-map
        :localleader
        (:nvm "j" #'org-random-todo-goto-new))))

(after! org-agenda
  (map! :map org-agenda-mode-map
        :localleader
        (:nvm "j" #'org-random-todo-goto-new)))

(use-package! beacon
  :config (beacon-mode 1))

(use-package! iscroll
  :config (iscroll-mode 1))

(use-package! diminish)

(use-package graphviz-dot-mode
  :config
  (setq graphviz-dot-indent-width 4))
  (setq graphviz-dot-preview-extension "svg")

(use-package! uiua-ts-mode
  :mode "\\.ua\\'")

(use-package! spacious-padding
  :config
    (spacious-padding-mode t)
)

(use-package! vertico-posframe
  :config
    (vertico-posframe-mode t)
    (map! :leader "tp" #'vertico-posframe-cleanup)
)

(after! lsp-mode
  (setq lsp-auto-execute-action nil)
  (setq lsp-modeline-diagnostics-enable nil)
  (defun lsp-toggle-mouse-docs ()
   (interactive)
   (if lsp-ui-doc-show-with-mouse
     (setq lsp-ui-doc-show-with-mouse nil)
     (setq lsp-ui-doc-show-with-mouse t)
   )
  )
)

(after! lsp-ui
  (message "after lsp-ui triggered")
  (setq lsp-ui-show-with-mouse t)
)

(use-package! lsp-treemacs
  :config
  (lsp-treemacs-sync-mode 1)
  (setq lsp-treemacs-errors-position-params '((side . left)))
)

(after! treesit
(defun ts-inspect ()
  (interactive)
  (when-let* ((nap (treesit-node-at (point))))
    (message "%S - %S" nap (treesit-node-type nap))))

(defun ts-query-root (query)
  (interactive "sQuery: ")
  (let ((ss0 (treesit-query-capture (treesit-buffer-root-node) query)))
    (message "%S" ss0))))

(after! haskell-ng-mode
  (map! :localleader
        :map haskell-ng-mode-map
        "n" #'flymake-goto-next-error
        "p" #'flymake-goto-prev-error
        "f" #'consult-flymake))

(after! treesit
(use-package! haskell-ng-mode
  :diminish haskell-ng-mode
  ;; :load-path "~/repos/haskell-ng-mode"
  :init
  (add-to-list 'treesit-language-source-alist '(haskell "https://github.com/tree-sitter/tree-sitter-haskell"))
  ; (add-to-list 'treesit-language-source-alist '(cabal ("https://gitlab.com/magus/tree-sitter-cabal.git" "main" "src" "gcc-13" "c++-13")))
  (add-to-list 'treesit-language-source-alist '(cabal ("https://gitlab.com/magus/tree-sitter-cabal.git")))
  (add-to-list 'major-mode-remap-alist '(haskell-mode . haskell-ng-mode))
  (add-to-list 'major-mode-remap-alist '(cabal-mode . cabal-ng-mode))
  (defalias 'haskell-mode #'haskell-ng-mode)
  (defalias 'cabal-mode #'cabal-ng-mode)
  :hook
  ;;(haskell-ng-mode . eglot-ensure)
  ;;(haskell-ng-mode . eldoc-documentation-tweak)
  (haskell-ng-mode . (lambda () (setq-local tab-width 2)))
  (haskell-ng-mode . (lambda () (setq mode-name "λ")))
  :config
  (use-package! ormolu)
  (map! :localleader
        :map haskell-ng-mode-map
        :nvm "'" #'haskell-ng-repl-run
        :nvm "h" #'hoogle-name
        :nvm "p" #'hackage-package
        (:prefix ("=" . "format")
         :nvm "=" #'ormolu-format-buffer)
        (:prefix ("e" . "eglot")
         :nvm "e" #'eglot
         :nvm "d" #'eldoc-documentation-tweak
         :nvm "D" #'eldoc-documentation-lsp-tweak
         :nvm "r" #'eglot-reconnect
         :nvm "q" #'eglot-shutdown)
        (:prefix ("t" . "treemacs")
         :nvm "c" #'lsp-treemacs-call-hierarchy
         :nvm "e" #'lsp-treemacs-errors-list
         :nvm "r" #'lsp-treemacs-references)
        (:prefix ("l" . "lsp")
         :nvm "m" #'lsp-toggle-mouse-docs
         :nvm "l" #'lsp
         :nvm "f" #'consult-flycheck
         :nvm "F" #'consult-lsp-diagnostics
         :nvm "i" #'toggle-import-lens-code
         :nvm "s" #'lsp-ui-sideline-mode
         :nvm "r" #'lsp-workspace-restart
         :nvm "q" #'lsp-workspace-shutdown))

  (map! :localleader
        :map cabal-ng-mode-map
        (:prefix ("=" . "format")
         :nvm "=" #'cabal-format-buffer
         :nvm "r" #'cabal-format-region)
        :nvm "p" #'hackage-package
        :nvm "h" #'hoogle-name
         )))

(defun hackage-package (package)
  "Open current PACKAGE at hackage."
  (interactive (list
                (read-string (format "Lookup package (%s): " (thing-at-point 'symbol))
                             nil nil (thing-at-point 'word))))
  (browse-url (format "https://hackage.haskell.org/package/%s" (url-hexify-string package))))

(defun hoogle-name (name)
  "Lookup NAME at hoogle."
  (interactive (list
                (read-string (format "Hoogle lookup: %s" (thing-at-point 'symbol))
                             nil nil (thing-at-point 'symbol))))
  (browse-url (format "https://hoogle.haskell.org/?hoogle=%s" (url-hexify-string name))))

(after! dumb-jump
  (add-to-list '+lookup-provider-url-alist '("hoogle"  "https://hoogle.haskell.org/?hoogle=%s"))
  (add-to-list '+lookup-provider-url-alist '("hackage"  "https://hackage.haskell.org/package/%s"))
)

(require 'haskell-ng-mode)

(use-package! lsp-haskell
  :config
  (setq
        lsp-haskell-plugin-stan-global-on nil
        lsp-haskell-plugin-import-lens-code-actions-on nil
        lsp-haskell-plugin-ghcide-type-lenses-config-mode t
        lsp-haskell-plugin-eval-global-on nil
        lsp-haskell-plugin-ghcide-type-lenses-global-on t
        lsp-haskell-plugin-import-lens-code-lens-on nil
        lsp-haskell-plugin-hlint-diagnostics-on t
        lsp-haskell-plugin-retrie-global-on nil
        lsp-haskell-plugin-alternate-number-format-global-on nil
        )
  (defun toggle-import-lens-code ()
   (interactive)
   (if lsp-haskell-plugin-import-lens-code-lens-on
     (setq lsp-haskell-plugin-import-lens-code-lens-on nil)
     (setq lsp-haskell-plugin-import-lens-code-lens-on t)
   )
   (lsp-workspace-restart (lsp--read-workspace))
  )
 )

(use-package! ob-haskell-ng
  ;; :load-path "~/repos/ob-haskell-ng"
  :config
  (setq org-babel-default-header-args '((:results . "replace output") (:exports . "both")))
)

(use-package! haskell-lite
  ; :load-path "~/repos/haskell-lite"
)

  (after! org
  (map! :localleader
        :map org-mode-map
        (:prefix ("m" . "haskell-ng-repl")
         :nvm "m" #'haskell-lite-repl-overlay
         :nvm "s" #'haskell-ng-repl-run
         :nvm "p" #'haskell-lite-prompt
         :desc "run n go" :nvm "g" (cmd! (haskell-ng-repl-run t))
         :nvm "q" #'haskell-lite-repl-quit
         :nvm "r" #'haskell-lite-repl-restart
         :nvm "b" #'haskell-lite-repl-show)))

  (after! org
  (map! :localleader
        :map haskell-ng-mode-map
        (:prefix ("m" . "haskell-ng-repl")
         :nvm "m" #'haskell-lite-repl-overlay
         :nvm "s" #'haskell-ng-repl-run
         :nvm "p" #'haskell-lite-prompt
         :desc "run n go" :nvm "g" (cmd! (haskell-ng-repl-run t))
         :nvm "q" #'haskell-lite-repl-quit
         :nvm "r" #'haskell-lite-repl-restart
         :nvm "b" #'haskell-lite-repl-show)))

(use-package! tidal
    :init
    (progn
      (setq tidal-interpreter "ghci")
      (setq tidal-interpreter-arguments (list "ghci" "-XOverloadedStrings" "-package" "tidal"))
      (setq tidal-boot-script-path "~/.config/emacs/.local/straight/repos/Tidal/BootTidal.hs")
      ))

(use-package! gptel
  :config
  (setq gptel-model 'claude-sonnet-4-5-20250929
        gptel-backend (gptel-make-anthropic "Claude"
                        :stream t
                        :key #'gptel-api-key-from-auth-source))

  ;; GPG/EPA configuration for .authinfo.gpg
  (setq epa-pinentry-mode 'loopback)
  (setq epg-gpg-program "/opt/homebrew/bin/gpg"))
