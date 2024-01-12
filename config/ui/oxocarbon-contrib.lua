local oxocarbon = require('oxocarbon').oxocarbon

vim.opt.background = "dark"

-- Transparent BG
vim.api.nvim_set_hl(0, "Normal", { bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "LineNr", { fg = oxocarbon.base03, bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "SignColumn", { fg = oxocarbon.base02, bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "NormalNC", { bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = oxocarbon.base02, bg = oxocarbon.none })

-- Indent Blankline
vim.api.nvim_set_hl(0, "IblIndent", { fg = oxocarbon.none, bg = oxocarbon.none })
vim.api.nvim_set_hl(0, "IblScope", { fg = oxocarbon.base02, bg = oxocarbon.none })

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

-- Neo-Tree
vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { fg = oxocarbon.base02, bg = oxocarbon.none })

-- Status Line
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = oxocarbon.none })
vim.opt.laststatus = 3

local modes = {
  ["n"] = "RW",
  ["no"] = "RO",

  ["v"] = "**",
  ["V"] = "**",
  ["\022"] = "**",

  ["s"] = "S",
  ["S"] = "SL",
  ["\019"] = "SB",

  ["i"] = "**",
  ["ic"] = "**",

  ["R"] = "RA",
  ["Rv"] = "Rv",

  ["c"] = "VIEX",
  ["cv"] = "VIEX",
  ["ce"] = "EX",

  ["r"] = "r",
  ["rm"] = "r",
  ["r?"] = "r",

  ["!"] = "!",

  ["t"] = "",
}

local function getLspDiagnostic()
  local count = {}
  local levels = {
    errors = "Error",
    warnings = "Warn",
    info = "Info",
    hints = "Hint",
  }

  for k, level in pairs(levels) do
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end

  local errors = ""
  local warnings = ""
  local hints = ""
  local info = ""

  if count["errors"] ~= 0 then
    errors = " %#DiagnosticError# " .. count["errors"]
  end
  if count["warnings"] ~= 0 then
    warnings = " %#DiagnosticWarn# " .. count["warnings"]
  end
  if count["hints"] ~= 0 then
    hints = " %#DiagnosticHint# " .. count["hints"]
  end
  if count["info"] ~= 0 then
    info = " %#DiagnosticInfo# " .. count["info"]
  end

  return errors .. warnings .. hints .. info .. "%#Normal#"
end

local function getFiletype()
  return "%#NormalNC#" .. vim.bo.filetype
end

local function getFileinfo(is_inactive)
  is_inactive = is_inactive or false

  local filename = vim.fn.expand("%")
  if filename == "" then
    filename = " kekw-nvim "
  else
    filename = " " .. vim.fn.expand("%:t") .. " "
  end

  local color = (is_inactive and "%#@comment#") or "%#Normal#"

  return color .. filename .. "%#NormalNC#"
end

local function getMode()
  local currentMode = vim.api.nvim_get_mode().mode
  return string.format(" %s ", modes[currentMode]):upper()
end

local function getLineNo()
  return "%#@comment# %l:%c %#Normal#"
end

local function updateModeColors()
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_color = "%#Normal#"

  if current_mode == "n" then
    mode_color = "%#StatusNormal#"
  elseif current_mode == "i" or current_mode == "ic" then
    mode_color = "%#StatusInsert#"
  elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
    mode_color = "%#StatusVisual#"
  elseif current_mode == "R" then
    mode_color = "%#StatusReplace#"
  elseif current_mode == "c" then
    mode_color = "%#StatusCommand#"
  elseif current_mode == "t" then
    mode_color = "%#StatusTerminal#"
  end

  return mode_color
end

local function getGitStatus()
  ---@diagnostic disable-next-line: undefined-field
  local git_info = vim.b.gitsigns_status_dict
  if not git_info or git_info.head == "" then
    return ""
  end
  local added = git_info.added and ("%#GitSignsAdd#+" .. git_info.added .. " ") or ""
  local changed = git_info.changed and ("%#GitSignsChange#~" .. git_info.changed .. " ") or ""
  local removed = git_info.removed and ("%#GitSignsDelete#-" .. git_info.removed .. " ") or ""
  if git_info.added == 0 then
    added = ""
  end
  if git_info.changed == 0 then
    changed = ""
  end
  if git_info.removed == 0 then
    removed = ""
  end
  return table.concat({
    added,
    changed,
    removed,
    "%#Normal# ",
    "%#GitSignsAdd# ",
    git_info.head,
    " %#NormalNC#",
  })
end

local function getWordCount()
  -- if im editing markdown, show me the word count
  if vim.bo.filetype == "md" or vim.bo.filetype == "markdown" then
    -- get the word count from vim's internals
    local wc = vim.fn.wordcount()

    -- get the actual number of words (or selected words if in visual mode)
    local count = wc.words
    if not (wc.visual_words == nil) then
      count = wc.visual_words
    end

    -- if there is only one word, show "word", not "words"
    local suffix = "words"
    if count == 1 then
      suffix = "word"
    end

    -- return [xx word(s)]
    return "%#@comment# [" .. tostring(count) .. " " .. suffix .. "]%#Normal#"
  else
    -- return nothing, not in a markdown file
    return ""
  end
end

Statusline = {}

function Statusline.active()
  return table.concat({
    "%#Statusline#",
    updateModeColors(),
    getMode(),

    "%#Normal# ",
    getFileinfo(),
    getLspDiagnostic(),

    "%=%#StatusLineExtra#",
    getGitStatus(),
    getFiletype(),
    getWordCount(),
    getLineNo(),
  })
end

function Statusline.inactive()
  return ""
end

function Statusline.short()
  return "%#StatuslineNC#   NvimTree"
end

vim.api.nvim_exec(
  [[
augroup Statusline
au!
au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
augroup END
  ]],
  false
)
