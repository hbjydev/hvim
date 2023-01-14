(import-macros {: use!
	        : unpack!
	        : hvim-init-modules!
		: hvim-compile-modules!
		: packadd!} :macros)

(packadd! packer.nvim)

(local {: init} (require :packer))

(local headless (= 0 (length (vim.api.nvim_list_uis))))
(init {:lockfile {:enable true
                  :path (.. (vim.fn.stdpath :config) :/lockfile.lua)}
       :compile_path (.. (vim.fn.stdpath :config) :/lua/packer_compiled.lua)
       :auto_reload_compiled false
       :display {:non_interactive headless}})

;; packer can manage itself
(use! :EdenEast/packer.nvim {:opt true :branch :feat/lockfile})

;; global dependencies
(use! :nvim-lua/plenary.nvim {:module :plenary})

;; init module system
(include :fnl.modules)
(hvim-init-modules!)

;; send packages to packer
(unpack!)

;; compile modules
(hvim-compile-modules!)
