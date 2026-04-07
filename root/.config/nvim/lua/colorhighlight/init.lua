local M = {}

local ns_id = vim.api.nvim_create_namespace("colorhighlight")
local timers = {}
local enabled = true
local hl_cache = {}

local function hue(p, q, t)
	if t < 0 then t = t + 1 end
	if t > 1 then t = t - 1 end
	if t < 1 / 6 then return p + (q - p) * 6 * t end
	if t < 1 / 2 then return q end
	if t < 2 / 3 then return p + (q - p) * (2 / 3 - t) * 6 end
	return p
end

local function hsl_to_rgb(h, s_pct, l_pct)
	h = h % 360
	local s, l = s_pct / 100, l_pct / 100
	if s == 0 then
		local v = math.floor(l * 255 + 0.5)
		return { r = v, g = v, b = v }
	end
	local q = l < 0.5 and l * (1 + s) or l + s - l * s
	local p = 2 * l - q
	return {
		r = math.floor(hue(p, q, h / 360 + 1 / 3) * 255 + 0.5),
		g = math.floor(hue(p, q, h / 360) * 255 + 0.5),
		b = math.floor(hue(p, q, h / 360 - 1 / 3) * 255 + 0.5),
	}
end

local function contrast_color(r, g, b)
	local function lin(c)
		c = c / 255
		return c <= 0.04045 and c / 12.92 or ((c + 0.055) / 1.055) ^ 2.4
	end
	local lum = 0.2126 * lin(r) + 0.7152 * lin(g) + 0.0722 * lin(b)
	return lum > 0.179 and "#000000" or "#ffffff"
end

local NUM    = "%s*(%d+)%s*"
local NUMF   = "%s*(%d+%.?%d*)%s*"
local NUMPCT = "%s*(%d+%.?%d*)%%%s*"

local PATTERNS = {
	{
		pat = "#(%x%x)(%x%x)(%x%x)",
		parse = function(r, g, b)
			return { r = tonumber(r, 16), g = tonumber(g, 16), b = tonumber(b, 16) }
		end,
	},
	{
		pat = "#(%x)(%x)(%x)",
		parse = function(r, g, b)
			local rv, gv, bv = tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)
			return { r = rv * 17, g = gv * 17, b = bv * 17 }
		end,
	},
	{
		pat = "rgb%(" .. NUM .. "," .. NUM .. "," .. NUM .. "%)",
		parse = function(r, g, b)
			return { r = tonumber(r), g = tonumber(g), b = tonumber(b) }
		end,
	},
	{
		pat = "rgba%(" .. NUM .. "," .. NUM .. "," .. NUM .. "," .. NUMF .. "%)",
		parse = function(r, g, b, _)
			return { r = tonumber(r), g = tonumber(g), b = tonumber(b) }
		end,
	},
	{
		pat = "hsl%(" .. NUMF .. "," .. NUMPCT .. "," .. NUMPCT .. "%)",
		parse = function(h, s, l)
			return hsl_to_rgb(tonumber(h), tonumber(s), tonumber(l))
		end,
	},
	{
		pat = "hsla%(" .. NUMF .. "," .. NUMPCT .. "," .. NUMPCT .. "," .. NUMF .. "%)",
		parse = function(h, s, l, _)
			return hsl_to_rgb(tonumber(h), tonumber(s), tonumber(l))
		end,
	},
}

local function get_or_create_hl(r, g, b)
	local key = string.format("%02x%02x%02x", r, g, b)
	if hl_cache[key] then return hl_cache[key] end
	local group = "CHL_" .. key:upper()
	vim.api.nvim_set_hl(0, group, { fg = contrast_color(r, g, b), bg = "#" .. key })
	hl_cache[key] = group
	return group
end

local function scan_line(buf, row, text)
	local pos = 1
	while pos <= #text do
		local bs, be, brgb = nil, nil, nil
		for _, e in ipairs(PATTERNS) do
			local s, en, c1, c2, c3, c4 = text:find(e.pat, pos)
			if s and (bs == nil or s < bs or (s == bs and (en - s) > (be - bs))) then
				local rgb = e.parse(c1, c2, c3, c4)
				if rgb and rgb.r >= 0 and rgb.g >= 0 and rgb.b >= 0
					and rgb.r <= 255 and rgb.g <= 255 and rgb.b <= 255 then
					bs, be, brgb = s, en, rgb
				end
			end
		end
		if not bs then break end
		vim.api.nvim_buf_set_extmark(buf, ns_id, row, bs - 1, {
			end_row  = row,
			end_col  = be,
			hl_group = get_or_create_hl(brgb.r, brgb.g, brgb.b),
			priority = 100,
		})
		pos = be + 1
	end
end

function M.highlight_buf(buf)
	if not enabled or not vim.api.nvim_buf_is_valid(buf) then return end
	local count = vim.api.nvim_buf_line_count(buf)
	if count > 5000 then
		local win = vim.fn.bufwinid(buf)
		if win == -1 then return end
		local top = vim.fn.line("w0", win) - 1
		local bot = vim.fn.line("w$", win)
		vim.api.nvim_buf_clear_namespace(buf, ns_id, top, bot)
		local lines = vim.api.nvim_buf_get_lines(buf, top, bot, false)
		for i, line in ipairs(lines) do scan_line(buf, top + i - 1, line) end
	else
		vim.api.nvim_buf_clear_namespace(buf, ns_id, 0, -1)
		local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
		for i, line in ipairs(lines) do scan_line(buf, i - 1, line) end
	end
end

local DEBOUNCE_MS = 150

local function debounced_highlight(buf)
	if timers[buf] then timers[buf]:stop(); timers[buf]:close(); timers[buf] = nil end
	local uv = vim.uv or vim.loop
	local t = uv.new_timer()
	timers[buf] = t
	t:start(DEBOUNCE_MS, 0, vim.schedule_wrap(function()
		if timers[buf] then timers[buf]:close(); timers[buf] = nil end
		M.highlight_buf(buf)
	end))
end

local function setup_autocmds()
	local aug = vim.api.nvim_create_augroup("colorhighlight", { clear = true })

	vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
		group = aug,
		callback = function(ev) M.highlight_buf(ev.buf) end,
	})

	vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "InsertLeave" }, {
		group = aug,
		callback = function(ev) debounced_highlight(ev.buf) end,
	})

	vim.api.nvim_create_autocmd({ "BufDelete", "BufUnload" }, {
		group = aug,
		callback = function(ev)
			if timers[ev.buf] then
				timers[ev.buf]:stop(); timers[ev.buf]:close(); timers[ev.buf] = nil
			end
		end,
	})

	vim.api.nvim_create_autocmd("WinScrolled", {
		group = aug,
		callback = function(ev)
			local buf = vim.api.nvim_win_get_buf(tonumber(ev.match))
			if vim.api.nvim_buf_line_count(buf) > 5000 then
				debounced_highlight(buf)
			end
		end,
	})

	vim.api.nvim_create_autocmd("ColorScheme", {
		group = aug,
		callback = function()
			hl_cache = {}
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if vim.api.nvim_buf_is_loaded(buf) then M.highlight_buf(buf) end
			end
		end,
	})
end

local function setup_commands()
	vim.api.nvim_create_user_command("ColorHighlightEnable", function()
		enabled = true
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_is_loaded(buf) then M.highlight_buf(buf) end
		end
		vim.notify("ColorHighlight: enabled", vim.log.levels.INFO)
	end, {})

	vim.api.nvim_create_user_command("ColorHighlightDisable", function()
		enabled = false
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_is_valid(buf) then
				vim.api.nvim_buf_clear_namespace(buf, ns_id, 0, -1)
			end
		end
		vim.notify("ColorHighlight: disabled", vim.log.levels.INFO)
	end, {})

	vim.api.nvim_create_user_command("ColorHighlightToggle", function()
		vim.cmd(enabled and "ColorHighlightDisable" or "ColorHighlightEnable")
	end, {})
end

function M.setup()
	setup_autocmds()
	setup_commands()
	local buf = vim.api.nvim_get_current_buf()
	if vim.api.nvim_buf_is_loaded(buf) then M.highlight_buf(buf) end
end

return M
