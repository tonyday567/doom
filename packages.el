;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/radian-software/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see radian-software/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)

(package! ef-themes)
(package! org-random-todo)
(package! beacon)
(package! iscroll)
(package! diminish)
(package! vertico-posframe)
(package! graphviz-dot-mode)
(package! uiua-ts-mode
  :recipe (:host github :repo "crmsnbleyd/uiua-ts-mode"))
(package! spacious-padding)
(package! aas)
(package! dashboard)

;; (package! combobulate)  ; Disabled due to SSH submodule issue
(package! lsp-treemacs)
(package! ormolu)

(package! lsp-haskell
  :recipe (:host github
           :repo "magthe/lsp-haskell"
  :branch "master"))

(package! haskell-ng-mode
  :recipe (:host gitlab
           :repo "tonyday567/haskell-ng-mode"
           :branch "lite-fixes"))

(package! ob-haskell-ng
  :recipe (:host github
           :repo "tonyday567/ob-haskell-ng"
           :branch "main"))

(package! haskell-lite
  :recipe (:host github
           :repo "tonyday567/haskell-lite"
           :branch "main"))

(package! tidal
  :recipe (:host github :repo "tonyday567/Tidal" :branch "haskell-ng"))

;(package! haskell-lsp
;  :recipe (:host github
;           :repo "emacs-lsp/lsp-haskell"
;           :branch "master"))
;

(package! gptel
  :recipe (:host github
           :repo "karthink/gptel"
           :branch "master"))

;;(package! haskell-ng-mode
;;  :recipe (:local-repo "~/repos/haskell-ng-mode"
;;  :build (:not compile)))

; https://github.com/doomemacs/doomemacs/issues/8089
(package! compat :pin "9a234d0")
