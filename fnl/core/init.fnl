;; add python provider and mason binaries
(set vim.env.PATH (.. vim.env.PATH ":" (vim.fn.stdpath :data) :/mason/bin))
(set vim.env.PATH (.. vim.env.PATH ":" (vim.fn.stdpath :config) :/bin))

(local cli (os.getenv :HVIM_CLI))

(if cli
  (require :packages)
  (do

    (require :packer_compiled)
    (fn disable-packer [command]
      (fn first-to-upper [str]
        (str:gsub "^%l" string.upper))

      (local packer-command (.. :Packer (first-to-upper command)))
      (vim.api.nvim_create_user_command packer-command
                                        (fn []
                                          (error! (.. "Please use the `nyoom` cli")))
                                        {}))

    (let [packer-commands [:install :update :compile :sync :status :lockfile]]
      (each [_ v (ipairs packer-commands)]
        (disable-packer v)))))
