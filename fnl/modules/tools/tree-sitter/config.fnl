(import-macros {: hvim-module-p!} :macros)
(local {: setup} (require :core.lib.setup))

(local treesitter-filetypes [:comment :help :fennel :vim :regex :query])

(hvim-module-p! typescript
  (table.insert treesitter-filetypes :typescript)
  (table.insert treesitter-filetypes :typescriptreact))

(setup :nvim-treesitter.configs
       {:ensure_installed treesitter-filetypes
        :sync_install true
	:highlight {:enable true :use_languagetree true}
	:indent {:enable true}})
