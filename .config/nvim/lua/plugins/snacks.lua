return {
  "folke/snacks.nvim",
  opts = {
    image = {
      enabled = true,
      -- ImageMagick is required to convert images to the supported formats (all except PNG).
      -- Also, MAKE SURE to ensure you are not missing any imagemagick dependencies, otherwise images might not display.
      -- Run `brew info imagemagick` on mac to see if all the dependencies are present.
      -- other dependencies:
      --   mac: pngpaste
      --   linux: xclip (X11) or wl-clipboard (wayland)
      doc = {
        inline = false,
        float = true,
      },
    },
  },
}
