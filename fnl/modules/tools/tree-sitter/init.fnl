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
      :requires [(pack :nvim-treesitter/nvim-treesitter-textobjects
                       {:opt true})]

      :setup (fn []
               (vim.api.nvim_create_autocmd
                 [:BufRead]
                 {:group (vim.api.nvim_create_augroup :nvim-treesitter
                                                      {})
                  :callback (fn []
                             (when (fn []
                                     (local file
                                            (vim.fn.expand "%"))
                                     (and (and (not= file
                                                     :NvimTree_1)
                                               (not= file
                                                     "[packer]"))
                                          (not= file
                                                "")))
                               (vim.api.nvim_del_augroup_by_name :nvim-treesitter)
                               ((. (require :packer)
                                   :loader) :nvim-treesitter)))}))})
