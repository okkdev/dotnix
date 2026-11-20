maki.setup({
  ui = {
    theme = "system",
    splash_animation = false,
    clock_format = "24h",
  },
  trust = {
    paths = { "~/code/personal/*" },
  },
})

require("semble")
require("lancet")
