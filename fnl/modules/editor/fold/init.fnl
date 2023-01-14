(import-macros {: use! : pack} :macros)

(use! :kevinhwang91/nvim-ufo
      {:hvim-module :editor.fold
       :after :nvim-treesitter
       :requires [:kevinhwang91/promise-async]})
;;       :requires [(pack :kevinhwang91/promise-async {:opt true})]})
