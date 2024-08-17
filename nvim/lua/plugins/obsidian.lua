return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	-- Load the plugin only if the directory exists
	cond = function()
		return vim.fn.isdirectory(vim.fn.expand("~/Nextcloud/obsidian/player2")) == 1
	end,
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",
		-- see below for full list of optional dependencies 👇
	},
	opts = {
		workspaces = {
			{
				name = "Player2",
				path = "~/Nextcloud/obsidian/player2",
			},
		},

		templates = {
			folder = "~/Nextcloud/obsidian/player2/templates",
			date_format = "%Y-%m-%d",
			time_format = "%Y%m%d%H%M%S",
		},

		-- Custom function to generate filename with datetime and optional title
		note_id_func = function(title)
			local datetime = os.date("%Y%m%d%H%M%S")
			if title then
				title = title:gsub("[^%w%s-]", ""):gsub("%s+", "-"):lower()
				return datetime .. "-" .. title
			else
				return datetime
			end
		end,

		-- Either 'wiki' or 'markdown'.
		preferred_link_style = "wiki",

		-- Optional, boolean or a function that takes a filename and returns a boolean.
		-- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
		disable_frontmatter = true,
	},

	config = function(_, opts)
		-- Function to replace template variables with actual values
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

		-- Function to create a new note and apply a template
		_G.CreateObsidianNoteWithTemplate = function()
			local template_dir = vim.fn.expand("~/Nextcloud/obsidian/player2/templates/")
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
					local filename = vim.fn.expand("~/Nextcloud/obsidian/player2/") .. datetime .. ".md"
					vim.cmd("e " .. filename)

					-- Read template content and replace variables
					local template_content = table.concat(vim.fn.readfile(template_dir .. choice .. ".md"), "\n")
					local rendered_content = render_template(template_content, { title = datetime })
					vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(rendered_content, "\n"))

					print("Created note: " .. filename .. " with template: " .. choice)
				else
					print("Template selection cancelled")
				end
			end)
		end

		-- Keybinding for creating a new note with a template
		vim.api.nvim_set_keymap(
			"n",
			"<leader>on",
			":lua CreateObsidianNoteWithTemplate()<CR>",
			{ noremap = true, silent = true }
		)

		-- Function to save and rename the current file based on markdown properties
		_G.SaveAndRenameMarkdownFile = function()
			local bufnr = vim.api.nvim_get_current_buf()
			local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
			local title
			local note_date

			for _, line in ipairs(lines) do
				if line:match("^title:%s") then
					title = line:gsub("^title:%s*", "")
				elseif line:match("^note:%s") then
					note_date = line:gsub("^note:%s*", "")
				end
			end

			if not title then
				print("No title property found in the markdown file.")
				return
			end

			if not note_date then
				print("No note property found in the markdown file.")
				return
			end

			-- Extract and format the note date (YYYYMMDD)
			local year = note_date:sub(1, 4)
			local month = note_date:sub(5, 6)
			local day = note_date:sub(7, 8)
			local formatted_date = string.format("%s-%s-%s", year, month, day)

			title = title:gsub("[^%w%s-]", ""):gsub("%s+", "-"):lower()
			local new_filename = formatted_date .. "-" .. title .. ".md"
			local new_filepath = vim.fn.expand("%:p:h") .. "/" .. new_filename
			local current_filepath = vim.fn.expand("%:p")

			-- Write the current buffer to the new file
			vim.cmd("write! " .. new_filepath)

			-- Delete the original file
			vim.fn.delete(current_filepath)

			-- Reload the buffer with the new file
			vim.api.nvim_buf_set_name(bufnr, new_filepath)
			vim.cmd("edit!")

			print("File saved and renamed to: " .. new_filename)
		end

		-- Keybinding for saving and renaming the current file
		vim.api.nvim_set_keymap(
			"n",
			"<leader>ob",
			":lua SaveAndRenameMarkdownFile()<CR>",
			{ noremap = true, silent = true }
		)
	end,
}
