(import-macros {: packadd! : set!} :macros)
(local {: setup} (require :core.lib.setup))

(packadd! promise-async)

(local {: openAllFolds : closeAllFolds} (require :ufo))

(set! foldcolumn :1)
(set! foldlevel 99)
(set! foldlevelstart 99)
(set! foldenable true)

(setup :ufo {:provider_selector (fn [bufnr filetype buftype]
                                  [:treesitter :indent])})
