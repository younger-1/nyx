local M = {}

M.plugins = {
  {
    "shadmansaleh/lualine.nvim",
    config = function()
      require("eden.modules.ui.lualine")
    end,
    requires = { "nvim-lua/lsp-status.nvim" },
  },
  {
    "folke/which-key.nvim",
    config = function()
      require("eden.modules.ui.whichkey")
    end,
  },
  {
    "glepnir/dashboard-nvim",
    cond = [[vim.g.started_by_firenvim]],
  },
  { "Yggdroot/indentLine" },
}

M.before = function()
  -- Dashboard ----------------------------------------------------------------
  vim.g.dashboard_custom_header = {
    "███████╗██████╗ ███████╗███╗   ██╗",
    "██╔════╝██╔══██╗██╔════╝████╗  ██║",
    "█████╗  ██║  ██║█████╗  ██╔██╗ ██║",
    "██╔══╝  ██║  ██║██╔══╝  ██║╚██╗██║",
    "███████╗██████╔╝███████╗██║ ╚████║",
    "╚══════╝╚═════╝ ╚══════╝╚═╝  ╚═══╝",
  }
  vim.g.dashboard_default_executive = "telescope"
  vim.g.dashboard_custom_section = {
    a = { description = { "  Recently Used Files" }, command = "Telescope oldfiles" },
    b = { description = { "  Find File          " }, command = "Telescope find_files" },
    c = { description = { "  Load Last Session  " }, command = "SessionLoad" },
    d = { description = { "  Find Word          " }, command = "Telescope live_grep" },
    e = { description = { "  File Browser       " }, command = "Telescope file_browser" },
  }
  vim.g.dashboard_custom_footer = { "github.com/EdenEast" }

  -- Indent Line --------------------------------------------------------------

  -- vim.g.indentLine_char = '│'  -- U+2502
  -- vim.g.indentLine_char = '┆'  -- U+2506
  vim.g.indentLine_char = "┊" -- U+250A

  vim.g.indentLine_enabled = 1
  vim.g.indentLine_concealcursor = "niv"
  vim.g.indentLine_showFirstIndentLevel = 0
  vim.g.indentLine_fileTypeExclude = {
    "defx",
    "denite",
    "startify",
    "dashboard",
    "tagbar",
    "vista_kind",
    "vista",
    "Help",
    "term",
    "toggerm",
  }
end

return M