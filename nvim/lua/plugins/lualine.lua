return {
  "nvim-lualine/lualine.nvim",
  optional = true,
  opts = function(_, opts)
    local Util = require("lazyvim.util")
    -- Safely attempt to require copilot status
    local function copilot_status()
      local ok, copilot = pcall(require, "copilot")
      if not ok or not copilot.status or not copilot.status.data then
        return ""
      end
      return copilot.status.data.status or ""
    end

    -- Insert into the right section (customize as needed)
    table.insert(opts.sections.lualine_x, {
      function()
        return " " .. copilot_status()
      end,
      cond = function()
        local ok, copilot = pcall(require, "copilot")
        return ok and copilot.status and copilot.status.data and copilot.status.data.status ~= nil
      end,
    })
  end,
}
