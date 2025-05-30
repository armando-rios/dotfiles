return {
  "andweeb/presence.nvim",
  config = function()
    require("presence").setup({
      main_image          = "file",
      -- client_id           = "",
      show_time           = true,
      buttons             = true,

      editing_text        = "Editing %s",
      file_explorer_text  = "Browsing %s",
      git_commit_text     = "Committing changes",
      plugin_manager_text = "Managing plugins",
      reading_text        = "Reading %s",
      workspace_text      = "Working on %s",
      line_number_text    = "Line %s out of %s",
    })
  end
}
