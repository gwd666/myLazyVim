-- add Shade.nvim to dim inactive windows
-- not wokring correctly leaving config in here just commented out
return {
  {
    "sunjon/shade.nvim",
    overlay_opacity = 50,
    opacity_step = 1,
    keys = {
      brightness_up = "<C-i>",
      brightness_down = "<C-I>",
      toggle = "<C-t>",
    },
  },
}
