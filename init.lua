local datadir = vim.fn.stdpath("data")

vim.opt.rtp:append(datadir .. "/lazy/lazy.nvim")
vim.opt.rtp:append(datadir .. "/lazy/hotpot.nvim")

if pcall(require, "hotpot") then
	-- Setup hotpot.nvim
	require("hotpot").setup({
		provide_require_fennel = true,
		enable_hotpot_diagnostics = false,
		compiler = {
			modules = {
				-- not default but recommended, align lua lines with fnl source
				-- for more debuggable errors, but less readable lua.
				correlate = true,
			},
			macros = {
				-- allow macros to access vim global, needed for nyoom modules
				env = "_COMPILER",
				compilerEnv = _G,
				allowGlobals = true,
				-- plugins = { "core.patch" },
			},
		},
	})
	-- Load profilers if nyoom is started in profile mode
	if os.getenv("NYOOM_PROFILE") then
		require("core.lib.profile").toggle()
	end
	-- local stdlib = require("core.lib")
	-- for k, v in pairs(stdlib) do
	-- 	rawset(_G, k, v)
	-- end
	require("core")

	--if pcall(require, "lazy") then
	--	require("lazy").setup(_G['hvim/pack'])
	--else
	--	print("Unable to require lazy")
	--end
else
	print("Unable to require hotpot")
end
