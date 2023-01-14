(import-macros {: use! : pack} :macros)

(use! :nvim-treesitter/nvim-treesitter
      {:hvim-module tools.tree-sitter
       :cmd [:TSInstall
	     :TSUpdate
	     :TSBufEnable
	     :TSBufDisable
	     :TSEnable
	     :TSDisable
	     :TSModuleInfo]
       :requires []})
