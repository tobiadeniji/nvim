local notify = require("notify")

notify.setup({
	notify._config(),
	background_colour = "#000000",
	fps = 30,
	icons = {
		DEBUG = " ",
		ERROR = " ",
		INFO = " ",
		WARN = " ",
		TRACE = " ",
	},
	level = 2,
	minimum_width = 50,
	render = "default",
	stages = "fade_in_slide_out",
	time_formats = {
		notification = "%T",
		notification_history = "%FT%T",
	},
	timeout = 3000,
	top_down = true,
})

notify("Welcome back, Tobi 😀\nHappy coding 🚀")
