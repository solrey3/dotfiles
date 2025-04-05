return {
  "nvim-lualine/lualine.nvim",
  optional = true,
  opts = function(_, opts)
    local function copilot_status()
      local ok, copilot = pcall(require, "copilot")
      if not ok or not copilot.status or not copilot.status.data then
        return ""
      end
      return " " .. (copilot.status.data.status or "")
    end

    -- Replace the existing Copilot indicator (if any)
    for i, section in ipairs(opts.sections.lualine_x) do
      if type(section) == "table" and section[1] and section[1]:find("copilot") then
        opts.sections.lualine_x[i] = copilot_status
        return
      end
    end

    -- Otherwise, just insert it safely
    table.insert(opts.sections.lualine_x, copilot_status)
  end,
}
