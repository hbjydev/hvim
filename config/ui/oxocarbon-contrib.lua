local oxocarbon = require('oxocarbon').oxocarbon

vim.opt.background = "dark"

-- Transparent BG
vim.api.nvim_set_hl(0, "Normal", { bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "LineNr", { fg = oxocarbon.base03, bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "SignColumn", { fg = oxocarbon.base02, bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "NormalNC", { bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = oxocarbon.base02, bg = oxocarbon.none })

-- Telescope
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = oxocarbon.base03, bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = oxocarbon.base03, bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "TelescopePromptNormal", { fg = oxocarbon.base05, bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = oxocarbon.base08, bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "TelescopeNormal", { fg = oxocarbon.none, bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = oxocarbon.base12, bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = oxocarbon.base11, bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = oxocarbon.base14, bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = oxocarbon.none, bg = oxocarbon.base01 })
vim.api.nvim_set_hl(0, "TelescopePreviewLine", { fg = oxocarbon.none, bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = oxocarbon.base14, bg = oxocarbon.none, bold = true, italic = true })

-- Diff
vim.api.nvim_set_hl(0, "DiffAdd", { bg = oxocarbon.base13, fg = oxocarbon.none })
vim.api.nvim_set_hl(0, "DiffAdded", { fg = oxocarbon.base13, bg = oxocarbon.none })

vim.api.nvim_set_hl(0, "DiffChanged", { fg = oxocarbon.base14, bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "DiffChange", { bg = oxocarbon.base14, fg = oxocarbon.none })

vim.api.nvim_set_hl(0, "DiffRemoved", { fg = oxocarbon.base10, bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "DiffDelete", { bg = oxocarbon.base10, fg = oxocarbon.none })

vim.api.nvim_set_hl(0, "DiffText", { bg = oxocarbon.base02, fg = oxocarbon.none })

-- Neo-Tree
vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { fg = oxocarbon.base02, bg = oxocarbon.none })
