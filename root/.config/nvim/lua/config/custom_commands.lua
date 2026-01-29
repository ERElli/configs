vim.api.nvim_create_user_command('Rfinder',
	function()
		local path = vim.api.nvim_buf_get_name(0)
		os.execute('open -R ' .. path)
	end,
	{}
)

vim.api.nvim_create_user_command('DboutToCsv',
	function()
		-- TODO: add error handling for input_filepath, output_filepath
		-- TODO: add checks for specific filetypes
		local input_filepath = vim.fn.resolve(vim.fn.expand("%:p"))
		
		local output_filepath = vim.fn.input("Enter output file path: ")

		local info = debug.getinfo(1, "S")
		local script_dir = vim.fn.fnamemodify(info.source:sub(2), ":h")
		local script_path = vim.fn.fnamemodify(script_dir .. "/" .. "./scripts/dadbod_dbout_to_csv.py", ":p")

		local python_script_path = vim.fn.expand(script_path)
		local command = string.format("python3 %s --input %s --output %s", python_script_path, input_filepath, output_filepath)

		print("Running command:", command)

		local result = vim.fn.system(command)

		if vim.v.shell_error ~= 0 then
			print("Error running script:", result)
		else
			print("Script executed successfully:", result)
		end
	end,
	{}
)

-- Jump to directory and open it
vim.api.nvim_create_user_command('Z', function(opts)
	-- Use a more robust approach to get the directory
	local handle = io.popen('zsh -ic "z ' .. opts.args .. ' 2>/dev/null && pwd" 2>/dev/null')
	if not handle then
		vim.notify("Failed to execute z command", vim.log.levels.ERROR)
		return
	end

	local result = handle:read("*a")
	handle:close()

	if not result or result == "" then
		vim.notify("Directory not found with z: " .. opts.args, vim.log.levels.WARN)
		return
	end

	-- Clean up the result (remove newlines and whitespace)
	local dir = result:gsub("^%s*(.-)%s*$", "%1")

	-- Check if directory exists
	if vim.fn.isdirectory(dir) == 0 then
		vim.notify("Directory does not exist: " .. dir, vim.log.levels.ERROR)
		return
	end

	-- -- is neo-tree installed
	-- local neotree_available, neotree = pcall(require, "neo-tree.command")
	-- if not neotree_available then  end
	--
	-- -- is neo-tree visible
	-- for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
	-- 	local buf = vim.api.nvim_win_get_buf(win)
	-- 	if vim.api.nvim_buf_get_option(buf, 'filetype') == 'neo-tree' then
	-- 		neotree.execute({ action = "refresh" })
	-- 		return  -- Found and refreshed, we're done
	-- 	end
	-- end

	vim.cmd('cd ' .. vim.fn.fnameescape(dir))
	vim.cmd('edit .')
	vim.notify("Changed to: " .. dir)
end, { nargs = 1 })

-- Jump to directory and open in new tab
vim.api.nvim_create_user_command('Zt', function(opts)
	local handle = io.popen('zsh -ic "z ' .. opts.args .. ' 2>/dev/null && pwd" 2>/dev/null')
	if not handle then
		vim.notify("Failed to execute z command", vim.log.levels.ERROR)
		return
	end

	local result = handle:read("*a")
	handle:close()

	if not result or result == "" then
		vim.notify("Directory not found with z: " .. opts.args, vim.log.levels.WARN)
		return
	end

	local dir = result:gsub("^%s*(.-)%s*$", "%1")

	if vim.fn.isdirectory(dir) == 0 then
		vim.notify("Directory does not exist: " .. dir, vim.log.levels.ERROR)
		return
	end

	vim.cmd('cd ' .. vim.fn.fnameescape(dir))
	vim.cmd('tabnew .')
	vim.notify("Opened in new tab: " .. dir)
end, { nargs = 1 })

-- Base64 decode visually selected text
vim.api.nvim_create_user_command('Base64Decode', function()
	-- Get the visual selection
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	
	-- Get the selected text
	local lines = vim.fn.getline(start_pos[2], end_pos[2])
	if #lines == 0 then
		vim.notify("No text selected", vim.log.levels.WARN)
		return
	end
	
	-- Handle single line vs multi-line selection
	local selected_text
	if #lines == 1 then
		-- Single line selection
		local line = lines[1]
		local start_col = start_pos[3]
		local end_col = end_pos[3]
		selected_text = string.sub(line, start_col, end_col)
	else
		-- Multi-line selection
		-- First line: from start column to end
		lines[1] = string.sub(lines[1], start_pos[3])
		-- Last line: from beginning to end column
		lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
		selected_text = table.concat(lines, "\n")
	end
	
	-- Store original for display
	local original_text = selected_text
	
	-- Remove any whitespace/newlines for base64 decoding
	local base64_text = selected_text:gsub("%s+", "")
	
	-- Decode base64 using system command
	local handle = io.popen('echo "' .. base64_text .. '" | base64 -d 2>/dev/null')
	if not handle then
		vim.notify("Failed to execute base64 decode command", vim.log.levels.ERROR)
		return
	end
	
	local decoded = handle:read("*a")
	handle:close()
	
	if not decoded or decoded == "" then
		vim.notify("Failed to decode base64 text", vim.log.levels.ERROR)
		return
	end
	
	-- Remove trailing newline if present
	decoded = decoded:gsub("\n$", "")
	
	-- Create replacement text with original as comment
	local comment_prefix = "# "  -- Default comment style
	
	-- Detect comment style based on filetype
	local filetype = vim.bo.filetype
	if filetype == "javascript" or filetype == "typescript" or filetype == "java" or filetype == "c" or filetype == "cpp" then
		comment_prefix = "// "
	elseif filetype == "lua" then
		comment_prefix = "-- "
	elseif filetype == "vim" then
		comment_prefix = '" '
	elseif filetype == "html" or filetype == "xml" then
		comment_prefix = "<!-- "
	end
	
	-- Combine decoded text with original as comment
	local replacement_text = decoded .. " " .. comment_prefix .. "base64: " .. base64_text
	local decoded_lines = vim.split(replacement_text, "\n")
	
	-- Convert to 0-based indexing and handle column bounds
	local start_row = start_pos[2] - 1
	local end_row = end_pos[2] - 1
	local start_col = start_pos[3] - 1
	local end_col = end_pos[3]  -- end_pos[3] is already the correct end column for nvim_buf_set_text
	
	vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, decoded_lines)
	
	-- Show notification
	local truncated_original = string.len(original_text) > 50 and string.sub(original_text, 1, 47) .. "..." or original_text
	vim.notify("Base64 decoded: '" .. truncated_original .. "' -> '" .. decoded .. "'")
end, { range = true })

