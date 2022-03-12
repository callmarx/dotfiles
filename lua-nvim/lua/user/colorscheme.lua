local status_ok, githubtheme = pcall(require, "github-theme")
if not status_ok then
  return
end

githubtheme.setup {
  colors = {},                     -- You can override specific color groups to use other groups or a hex color
  comment_style =	"italic",        -- Highlight style for comments (check :help highlight-args for options)
  dark_float = false,              -- Float windows like the lsp diagnostics windows get a darker background.
  dark_sidebar = true,             -- Sidebar like windows like NvimTree get a darker background
  dev = false,                     -- Developer Mode.
  hide_end_of_buffer = true,       -- Enabling this option, will hide filler lines (~) after the end of the buffer
  hide_inactive_statusline = true, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard StatusLine.
  keyword_style = "italic",        -- Highlight style for keywords (check :help highlight-args for options)
  msg_area_style = "NONE",         -- Highlight style for messages and cmdline (check :help highlight-args for options)
  sidebars = {},                   -- Set a darker background on sidebar-like windows. For example: {"qf", "vista_kind", "terminal", "packer"}
  theme_style = "dimmed",            -- Set theme variant (options: dark/dimmed/dark_default/dark_colorblind/light/light_default/light_colorblind)
  transparent = false,             -- Enable this to disable setting the background color
  variable_style = "NONE",         -- Highlight style for variables and identifiers (check :help highlight-args for options)
}
