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

    -- Replace existing Copilot indicator (safely)
    local replaced = false
    for i, section in ipairs(opts.sections.lualine_x or {}) do
      if type(section) == "table" and type(section[1]) == "string" and section[1]:find("copilot") then
        opts.sections.lualine_x[i] = copilot_status
        replaced = true
        break
      end
    end

    if not replaced then
      table.insert(opts.sections.lualine_x, copilot_status)
    end
  end,
}
