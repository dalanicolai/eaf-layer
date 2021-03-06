;;; packages.el --- eaf layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2020 Sylvain Benner & Contributors
;;
;; Author: Daniel Nicolai <dalanicolai@daniel-fedora>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst eaf-packages
  '((eaf :location (recipe
                                            :fetcher github
                                            :repo  "dalanicolai/emacs-application-framework"
                                            :files ("*")))))

(defun eaf/init-eaf ()
  (use-package eaf
    ;; (eaf-bind-key clear_focus "C-f" eaf-browser-keybinding)
    ;; (define-key eaf-mode-map (kbd "<escape>") 'eaf-proxy-clear_focus)
    :defer t

    :init
    (spacemacs/declare-prefix "ab" "eaf-browser")
    (spacemacs/declare-prefix "abq" "quick-launch-website")

    (spacemacs/set-leader-keys "abo" 'eaf-open-browser)
    (spacemacs/set-leader-keys "abs" 'eaf-search-it)
    (spacemacs/set-leader-keys "abb" 'eaf-open-bookmark)
    (spacemacs/set-leader-keys "abh" 'eaf-open-browser-with-history)


    (spacemacs/set-leader-keys "abqd" 'duckduckgo)
    (spacemacs/set-leader-keys "abqw" 'wikipedia)
    (spacemacs/set-leader-keys "abqy" 'youtube)

    (setq eaf-browser-keybinding
          '(
            ("C--" . "zoom_out")
            ("C-=" . "zoom_in")
            ("C-0" . "zoom_reset")
            ("C-s" . "search_text_forward")
            ("C-r" . "search_text_backward")
            ("C-n" . "scroll_up")
            ("C-p" . "scroll_down")
            ("C-f" . "scroll_right")
            ("C-b" . "scroll_left")
            ("C-v" . "scroll_up_page")
            ("C-y" . "yank_text")
            ("C-w" . "kill_text")
            ("M-e" . "atomic_edit")
            ("M-c" . "caret_toggle_browsing")
            ("M-D" . "select_text")
            ("M-s" . "open_link")
            ("M-S" . "open_link_new_buffer")
            ("M-d" . "open_link_background_buffer")
            ("C-/" . "undo_action")
            ("M-_" . "redo_action")
            ("M-w" . "copy_text")
            ("M-f" . "history_forward")
            ("M-b" . "history_backward")
            ("M-q" . "clear_cookies")
            ("C-t" . "toggle_password_autofill")
            ("C-d" . "save_page_password")
            ("M-a" . "toggle_adblocker")
            ("C-M-q" . "clear_history")
            ("C-M-i" . "import_chrome_history")
            ("M-v" . "scroll_down_page")
            ("M-<" . "scroll_to_begin")
            ("M->" . "scroll_to_bottom")
            ("M-p" . "duplicate_page")
            ("M-t" . "new_blank_page")
            ("<" . "insert_or_select_left_tab")
            (">" . "insert_or_select_right_tab")
            ("j" . "insert_or_scroll_up")
            ("k" . "insert_or_scroll_down")
            ("h" . "insert_or_scroll_left")
            ("l" . "insert_or_scroll_right")
            ("f" . "insert_or_open_link")
            ("F" . "insert_or_open_link_new_buffer")
            ("B" . "insert_or_open_link_background_buffer")
            ("c" . "insert_or_caret_at_line")
            ("J" . "insert_or_scroll_up_page")
            ("K" . "insert_or_scroll_down_page")
            ("H" . "insert_or_history_backward")
            ("L" . "insert_or_history_forward")
            ("t" . "insert_or_new_blank_page")
            ("T" . "insert_or_recover_prev_close_page")
            ("i" . "insert_or_focus_input")
            ("I" . "insert_or_open_downloads_setting")
            ("r" . "insert_or_refresh_page")
            ("g" . "insert_or_scroll_to_begin")
            ("x" . "insert_or_close_buffer")
            ("G" . "insert_or_scroll_to_bottom")
            ("-" . "insert_or_zoom_out")
            ("=" . "insert_or_zoom_in")
            ("0" . "insert_or_zoom_reset")
            ("m" . "insert_or_save_as_bookmark")
            ("o" . "insert_or_open_browser")
            ;; ("y" . "insert_or_download_youtube_video")
            ("y" . "insert_or_copy_text")
            ("Y" . "insert_or_download_youtube_audio")
            ("p" . "insert_or_toggle_device")
            ("P" . "insert_or_duplicate_page")
            ("1" . "insert_or_save_as_pdf")
            ("2" . "insert_or_save_as_single_file")
            ("v" . "insert_or_view_source")
            ("e" . "insert_or_edit_url")
            ("M-C" . "copy_code")
            ("C-M-f" . "copy_link")
            ("C-a" . "select_all_or_input_text")
            ("M-u" . "clear_focus")
            ("C-j" . "open_downloads_setting")
            ("M-o" . "eval_js")
            ("M-O" . "eval_js_file")
            ("<escape>" . "eaf-browser-send-esc-or-exit-fullscreen")
            ("M-," . "eaf-send-down-key")
            ("M-." . "eaf-send-up-key")
            ("M-m" . "eaf-send-return-key")
            ("<f5>" . "refresh_page")
            ("<f12>" . "open_devtools")
            ("<C-return>" . "eaf-send-ctrl-return-sequence")
            ))
    :config
    (setq browse-url-browser-function 'eaf-open-browser)
    (eaf-setq eaf-browser-enable-adblocker "true"))

; remove compiled file necessary to suppress clear_focus variable non-existent
; error (eaf is not yet meant to be installed with quelpa, see
; `https://github.com/manateelazycat/emacs-application-framework#install')
  ;; (when (locate-library "eaf-evil.elc") 
  ;;   (delete-file))

  (use-package eaf-evil
    :after eaf
    :config
    (setq eaf-evil-leader-keymap  spacemacs-cmds)

    (define-key key-translation-map (kbd "SPC")
      (lambda (prompt)
        (if (derived-mode-p 'eaf-mode)
            (if (eaf-call "call_function" eaf--buffer-id "is_focus")
                (kbd "SPC")
              (kbd "C-SPC")))))

    (setq eaf-evil-leader-for-major-keymap (make-sparse-keymap) )
    (define-key eaf-evil-leader-for-major-keymap (kbd "h") 'eaf-open-browser-with-history)
    (add-hook 'evil-normal-state-entry-hook
              (lambda ()
                (when (derived-mode-p 'eaf-mode)
                  (define-key eaf-mode-map (kbd "C-,") eaf-evil-leader-for-major-keymap)
                  ;; (setq emulation-mode-map-alists
                  ;;       (delq 'evil-mode-map-alist emulation-mode-map-alists))
                  )))
    (define-key key-translation-map (kbd ",")
      (lambda (prompt)
        (if (derived-mode-p 'eaf-mode)
            (if (eaf-call "call_function" eaf--buffer-id "is_focus")
                (kbd ",")
              (kbd "C-,")))))))

;;; packages.el ends here
