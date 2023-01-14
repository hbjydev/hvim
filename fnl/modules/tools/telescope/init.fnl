(import-macros {: use! : pack} :macros)

(use! :nvim-telescope/telescope.nvim
      {:hvim-module tools.telescope
       :module [:telescope]
       :cmd :Telescope
       :requires [(pack :nvim-telescope/telescope-ui-select.nvim {:opt true})]})
