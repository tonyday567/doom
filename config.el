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
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;;(setq doom-font (font-spec :family "Iosevka ss02" :size 14 :weight 'light)
;;      doom-variable-pitch-font (font-spec :family "Iosevka etoile" :size 14))
(setq doom-font (font-spec :family "Victor Mono")
      doom-variable-pitch-font (font-spec :family "Iosevka Aile"))

;;(setq doom-font (font-spec :family "Iosevka")
;;      doom-variable-pitch-font (font-spec :family "Iosevka Aile"))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-Iosvkem)
(setq doom-theme 'modus-operandi)
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

(setq evil-split-window-below t
      evil-vsplit-window-right t
      confirm-kill-emacs nil
      confirm-kill-processes nil
      shift-select-mode t
      window-combination-resize t
      case-fold-search t
      auto-save-default t)

;; setq-default sets variables that are usually local to buffers
(setq-default truncate-lines nil
              indent-tabs-mode nil)

(setq evil-kill-on-visual-paste nil
      evil-want-C-u-scroll nil
      evil-want-integration t
      evil-want-keybinding nil
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

(evil-define-key 'motion 'global "e"  #'evil-forward-after-word-end)
(evil-define-key 'motion 'global "E"  #'evil-forward-after-WORD-end)

(setq vertico-sort-function #'vertico-sort-history-alpha)
(setq avy-all-windows t)
(setq-default spell-fu-mode nil)

(map!
   :leader "s f" #'consult-find
   :leader "bo" #'consult-buffer-other-window
   :leader "s y" #'consult-yank-from-kill-ring
   "M-#" #'consult-register-load
   "M-'" #'consult-register-store       ;orig. abbrev-prefix-mark (unrelated)
   "C-M-#" #'consult-register
   [remap jump-to-register] #'consult-register-load
   ;; Other custom bindings
   ;; M-g bindings (goto-map)
   "M-g e" #'consult-compile-error
   "M-g g" #'consult-goto-line          ;orig. goto-line
   "M-g M-g" #'consult-goto-line        ;orig. goto-line
   "M-g o" #'consult-outline            ;Alternative: consult-org-heading
   "M-g m" #'consult-mark
   "M-g k" #'consult-global-mark
   "M-g I" #'consult-imenu-multi

   ;; M-s bindings (search-map)
   "M-s k" #'consult-keep-lines
   "M-s u" #'consult-focus-lines

   ;; Isearch integration
   :map isearch-mode-map
   "M-e" #'consult-isearch-history      ;orig. isearch-edit-string
   "M-s e" #'consult-isearch-history    ;orig. isearch-edit-string
   ;; Minibuffer history
   :map minibuffer-local-map
   "M-r" #'consult-history     ;orig. previous-matching-history-element
   ;; Redundant with Doom's :config default bindings
   :map global-map
   "M-g f" #'consult-flymake
   "M-s d" #'consult-find          ;does not cache files like Doom & Projectile
   "M-s r" #'consult-ripgrep
   "M-s D" #'consult-locate
   [remap Info-search] #'consult-info
   "M-X" #'consult-mode-command)

(map! :map help-map "TAB" #'consult-info)

(use-package orderless
  :init
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles . (partial-completion))))))

(after! git-gutter
  (setq git-gutter:disabled-modes '(org-mode image-mode))
  (global-git-gutter-mode -1)
  (remove-hook 'find-file-hook #'+vc-gutter-init-maybe-h)
  (map!
   :leader
   :nvm "tv" #'git-gutter-mode
   :desc "git-gutter-mode")
)

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

(define-key global-map (kbd "C-M-s") 'isearch-forward-other-window)
(define-key global-map (kbd "C-M-r") 'isearch-backward-other-window)

(setq erc-autojoin-channels-alist '(("libera.chat" "#haskell" "#emacs")))
(setq erc-hide-list '("JOIN" "PART" "QUIT"))
(setq erc-hide-timestamps t)
(setq erc-autojoin-timing 'ident)
;; (erc-prompt-for-nickserv-password nil)
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                              "324" "329" "332" "333" "353" "477"))

(map! ;; removes from kill ring
      [remap backward-kill-word] #'doom/delete-backward-word
      ;; replaces just-one-space
      "M-SPC" #'cycle-spacing
      [remap ibuffer] #'ibuffer-jump
      )

(map!
 (:map 'override
   :nvm "gss" #'evil-avy-goto-char-timer
   :nvm "gs/" #'evil-avy-goto-char-2))

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
  (setq
   org-startup-folded 'overview
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
   org-agenda-block-separator ?─)
   (remove-hook 'org-mode-hook 'flyspell-mode)
   (setq-default org-todo-keywords '((sequence "ToDo(t)" "Next(n)" "Blocked(b)" "|" "Done(d!)")))
)

(map! (:after evil-org
       :map evil-org-mode-map
       :n "gk" (cmd! (if (org-at-heading-p)
                         (org-backward-element)
                       (evil-previous-visual-line)))
       :n "gj" (cmd! (if (org-at-heading-p)
                         (org-forward-element)
                       (evil-next-visual-line)))))

(after! org-agenda
  :config
  (setq org-agenda-files
   '("~/org")))

(after! org-agenda
  :config
  (setq org-agenda-span 'week
        org-agenda-use-time-grid nil
        org-agenda-start-day "-0d"
        org-agenda-block-separator nil
        org-agenda-show-future-repeats nil
        org-agenda-compact-blocks t
        org-agenda-window-setup 'other-window
        org-agenda-show-all-dates nil
        org-agenda-prefix-format
         '((agenda . " %-12t")
           (todo . " %-12:c")
           (tags . " %-12:c")
           (search . " %-12:c")))
  (add-to-list 'org-modules 'org-habit)
  (require 'org-habit)
  (setq org-habit-graph-column 32)
  (setq org-habit-following-days 2)
  (setq org-habit-preceding-days 20)
  (setq org-log-into-drawer t)
  (setq org-agenda-custom-commands
         '(("z" "custom agenda"
            ((agenda "" ((org-agenda-span 'week)
                         (org-agenda-overriding-header "")))
             (alltodo "" ((org-agenda-overriding-header "")
                          ))))))
  (map! :leader "oz" #'agenda-z)
  (map! :map org-agenda-mode-map
        :localleader
        (:nvm "l" #'org-agenda-log-mode
         :nvm "j" #'org-random-todo-goto-new)))

(defun agenda-z ()
  (interactive)
  (org-agenda nil "z"))

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
  (org-yank-into-new-block "src haskell :results output"))

(defun org-new-block-haskell ()
  (interactive)
  (org-new-block "src haskell :results output"))

(defun org-yank-into-new-quote ()
  (interactive)
  (org-yank-into-new-block "quote"))
