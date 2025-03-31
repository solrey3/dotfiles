-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local function render_template(content, vars)
  vars = vim.tbl_extend("force", {
    date = os.date("%Y-%m-%d"),
    time = os.date("%H:%M:%S"),
    datetime = os.date("%Y-%m-%d %H:%M:%S"),
    uuid = vim.fn.systemlist("uuidgen")[1],
  }, vars or {})

  return (content:gsub("{{(.-)}}", function(key)
    return vars[key] or "{{" .. key .. "}}"
  end))
end

local function create_note_with_template()
  local template_dir = vim.fn.expand("~/Repos/github.com/solrey3/notes/templates/")
  local inbox_dir = vim.fn.expand("~/Repos/github.com/solrey3/notes/inbox/")
  local templates = vim.fn.globpath(template_dir, "*.md", false, true)

  if #templates == 0 then
    print("No templates found in " .. template_dir)
    return
  end

  local choices = {}
  for _, template in ipairs(templates) do
    table.insert(choices, vim.fn.fnamemodify(template, ":t:r"))
  end

  vim.ui.select(choices, { prompt = "Choose a template:" }, function(choice)
    if choice then
      local datetime = os.date("%Y%m%d%H%M%S")
      local filename = inbox_dir .. datetime .. ".md"
      vim.cmd("e " .. filename)

      local template_content = table.concat(vim.fn.readfile(template_dir .. choice .. ".md"), "\n")
      local rendered_content = render_template(template_content, { title = datetime })
      vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(rendered_content, "\n"))

      print("Created note: " .. filename .. " with template: " .. choice)
    else
      print("Template selection cancelled")
    end
  end)
end

local function save_and_rename_file()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local title, note_date

  for _, line in ipairs(lines) do
    if line:match("^title:%s") then
      title = line:gsub("^title:%s*", "")
    elseif line:match("^note:%s") then
      note_date = line:gsub("^note:%s*", "")
    end
  end

  if not title or not note_date then
    print("Missing title or note date.")
    return
  end

  local year, month, day = note_date:sub(1, 4), note_date:sub(5, 6), note_date:sub(7, 8)
  local formatted_date = string.format("%s-%s-%s", year, month, day)

  title = title:gsub("[^%w%s-]", ""):gsub("%s+", "-"):lower()
  local new_filename = formatted_date .. "-" .. title .. ".md"
  local new_filepath = vim.fn.expand("%:p:h") .. "/" .. new_filename
  local current_filepath = vim.fn.expand("%:p")

  vim.cmd("write! " .. new_filepath)
  vim.fn.delete(current_filepath)
  vim.api.nvim_buf_set_name(bufnr, new_filepath)
  vim.cmd("edit!")

  print("File saved and renamed to: " .. new_filename)
end

-- Keymaps
vim.keymap.set("n", "<leader>on", create_note_with_template, { desc = "New Note from Template" })
vim.keymap.set("n", "<leader>ob", save_and_rename_file, { desc = "Save and Rename Note" })
