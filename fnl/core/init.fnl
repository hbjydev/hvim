;; add python provider and mason binaries
(set vim.env.PATH (.. vim.env.PATH ":" (vim.fn.stdpath :data) :/mason/bin))
(set vim.env.PATH (.. vim.env.PATH ":" (vim.fn.stdpath :config) :/bin))

(local cli (os.getenv :HVIM_CLI))

(if cli
  (require :packages)
  (do
    (import-macros {: set!} :macros)

    ;; numbering
    (set! number)
    (set! relativenumber)

    ;; indentation
    (set! tabstop 4)
    (set! softtabstop 4)
    (set! shiftwidth 4)
    (set! expandtab)
    (set! smartindent)

    ;; swap, backup & undo
    (set! swapfile false)
    (set! backup false)
    (set! undodir (.. (vim.fn.stdpath :data) :undo))
    (set! undofile)

    ;; search
    (set! hlsearch)
    (set! incsearch)

    ;; others
    (set! wrap false)
    (set! termguicolors)
    (set! scrolloff 8)
    (set! colorcolumn :80)
    (set! cursorline)

    ;; packaging
    (require :packer_compiled)
    (fn disable-packer [command]
      (fn first-to-upper [str]
        (str:gsub "^%l" string.upper))

      (local packer-command (.. :Packer (first-to-upper command)))
      (vim.api.nvim_create_user_command packer-command
                                        (fn []
                                          (error! (.. "Please use the `nyoom` cli")))
                                        {}))

    ;; disable packer commands
    (let [packer-commands [:install :update :compile :sync :lockfile]]
      (each [_ v (ipairs packer-commands)]
        (disable-packer v)))))
