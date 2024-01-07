;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Projects/adlawson/notes/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; Start emacs server unless one is already running
(require 'server)
(unless server-process (server-start))

;; Evil soften ex-command key to `;`
;; https://www.reddit.com/r/DoomEmacs/comments/p1qrpb/remapping_to/
(dolist (state '(motion normal visual))
  (evil-define-key state 'global (kbd ";") 'evil-ex))

;; Disable lsp-terraform to workaround a bug with its config.
;; https://github.com/emacs-lsp/lsp-mode/issues/3577#issuecomment-1709232622
(after! lsp-mode
  (delete 'lsp-terraform lsp-client-packages))


;;;
;;; Keybindings
;;; https://discourse.doomemacs.org/t/how-to-re-bind-keys/56
;;;

;; Mouse tracking and scrolling
;; https://github.com/syl20bnr/spacemacs/issues/4591
(unless window-system
  (xterm-mouse-mode t)
  (map! "<mouse-4>" 'scroll-down-line
        "<mouse-5>" 'scroll-up-line))

;; Window keys
(unless window-system
  (map! :map evil-normal-state-map
        :prefix "<SPC> w"
        "e" 'doom/window-enlargen))

;; Editor keys
(defun adlawson/evil-ex-global-substitute () (interactive) (evil-ex "%s/"))
(defun adlawson/evil-ex-visual-substitute () (interactive) (evil-ex "'<,'>s/"))
(map! :map evil-normal-state-map
      "C-h" 'evil-shift-left-line
      "C-j" 'drag-stuff-down
      "C-k" 'drag-stuff-up
      "C-l" 'evil-shift-right-line
      "g /" 'adlawson/evil-ex-global-substitute)
(map! :map evil-visual-state-map
      "C-j" 'drag-stuff-down
      "C-k" 'drag-stuff-up
      "g /" 'adlawson/evil-ex-visual-substitute)

;; Golang keys
(map! :after go
      :map go-mode-map)
