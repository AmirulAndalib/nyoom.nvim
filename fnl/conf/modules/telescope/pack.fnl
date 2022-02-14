(import-macros {: use-package! : pack} :conf.macros)

(use-package! :nvim-telescope/telescope.nvim
              {:after :telescope-fzf-native.nvim
               :requires [(pack :nvim-lua/popup.nvim
                                {:cmd :Telescope})
                          (pack :nvim-lua/plenary.nvim
                                {:after :popup.nvim})
                          (pack :nvim-telescope/telescope-file-browser.nvim
                                {:cmd "Telescope file_browser"})
                          (pack :nvim-telescope/telescope-packer.nvim
                                {:cmd "Telescope packer"})
                          (pack :nvim-telescope/telescope-frecency.nvim
                                {:requires [:tami5/sqlite.lua]
                                 :cmd "Telescope frecency"})
                          (pack :nvim-telescope/telescope-fzf-native.nvim
                                {:run :make :after :plenary.nvim})]
               :config (fn []
                         (local {: setup} (require :telescope))
                         (local ffi (require :ffi))

                         (setup {:defaults {:borderchars {1 " "
                                                          2 " "
                                                          3 " "
                                                          4 " "
                                                          5 " "
                                                          6 " "
                                                          7 " "
                                                          8 " "}
                                            :prompt_prefix "   "
                                            :selection_caret "  "
                                            :entry_prefix "  "
                                            :sorting_strategy :ascending
                                            :layout_strategy :horizontal
                                            :layout_config {:horizontal {:prompt_position :top
                                                                         :preview_width 0.55
                                                                         :results_width 0.8}
                                                            :vertical {:mirror false}
                                                            :width 0.87
                                                            :height 0.8
                                                            :preview_cutoff 120}
                                            :use_less true
                                            :set_env {:COLORTERM :truecolor}
                                            :dynamic_preview_title true}})

                         ;; load our extensions
                         ((. (require :telescope) :load_extension) :fzf)
                         ((. (require :telescope) :load_extension) :packer)
                         ((. (require :telescope) :load_extension) :file_browser)

                         ;; only load smart history if sqlite is available
                         (when (ffi.load :libsqlite3)
                           ((. (require :telescope) :load_extension) :frecency)))})
