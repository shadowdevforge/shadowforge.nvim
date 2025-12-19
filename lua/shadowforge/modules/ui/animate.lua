-- =============================================================================
--  READ ONLY FILE
--  shadowforge/modules/ui/animate.lua
-- =============================================================================
return {
	"echasnovski/mini.animate",
	event = "VeryLazy",
	cond = function()
		-- Only load if animations are enabled in user config
		return require("shadowforge.config").options.ui.animations
	end,
	opts = function()
		-- Don't animate scrolling (Snacks handles that better)
		local animate = require("mini.animate")
		return {
			resize = {
				timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
			},
			scroll = {
				enable = false, -- Snacks.scroll is smoother
			},
			cursor = {
				enable = true, -- Smooth cursor movement
				timing = animate.gen_timing.linear({ duration = 80, unit = "total" }),
			},
		}
	end,
}
