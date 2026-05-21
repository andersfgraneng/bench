local M = {}

-- Base tools always loaded (neovim config itself is Lua, TOML appears everywhere)
local BASE = {
	lsp = { "lua_ls", "taplo" },
	treesitter = { "lua", "vim", "vimdoc", "markdown", "markdown_inline", "diff", "gitcommit", "yaml", "json" },
	formatters = { lua = { "stylua" } },
	linters = {},
}

-- Maps mise tool names to neovim language features
local TOOL_MAP = {
	node = {
		lsp = { "ts_ls", "html", "tailwindcss" },
		treesitter = { "javascript", "typescript", "tsx", "html", "css" },
		formatters = {
			javascript = { "prettierd", "prettier", stop_after_first = true },
			javascriptreact = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			typescriptreact = { "prettierd", "prettier", stop_after_first = true },
			html = { "prettierd", "prettier", stop_after_first = true },
			css = { "prettierd", "prettier", stop_after_first = true },
			json = { "prettierd", "prettier", stop_after_first = true },
		},
		linters = {
			javascript = { "eslint" },
			javascriptreact = { "eslint" },
			typescript = { "eslint" },
			typescriptreact = { "eslint" },
		},
	},
	python = {
		lsp = { "pyrefly" },
		treesitter = { "python" },
		formatters = { python = { "ruff" } },
		linters = { python = { "ruff", "pyrefly" } },
	},
	rust = {
		lsp = { "rust_analyzer" },
		treesitter = { "rust" },
		formatters = { rust = { "rustfmt", lsp_format = "fallback" } },
		linters = { rust = { "clippy" } },
	},
	go = {
		lsp = { "gopls" },
		treesitter = { "go", "gomod", "gowork", "gosum" },
		formatters = { go = { "gofmt" } },
		linters = { go = { "golangci_lint" } },
	},
	ruby = {
		lsp = { "ruby_lsp" },
		treesitter = { "ruby" },
		formatters = { ruby = { "rubocop" } },
		linters = { ruby = { "rubocop" } },
	},
	java = {
		lsp = { "jdtls" },
		treesitter = { "java" },
		formatters = {},
		linters = {},
	},
	terraform = {
		lsp = { "terraformls" },
		treesitter = { "terraform", "hcl" },
		formatters = { terraform = { "terraform_fmt" } },
		linters = { terraform = { "tflint" } },
	},
	-- Aliases for common alternate names
	nodejs = "node",
	python3 = "python",
	golang = "go",
}

-- Project-file detectors for tools not declared in mise (e.g. Docker, GitHub Actions)
local PROJECT_DETECTORS = {
	{
		check = function(root)
			return vim.fn.isdirectory(root .. "/.github/workflows") == 1
		end,
		features = {
			lsp = { "gh_actions_ls" },
			treesitter = {},
			formatters = {},
			linters = { ["yaml.ghaction"] = { "actionlint" } },
		},
	},
	{
		check = function(root)
			return vim.fn.filereadable(root .. "/Dockerfile") == 1
				or vim.fn.filereadable(root .. "/docker-compose.yml") == 1
				or vim.fn.filereadable(root .. "/docker-compose.yaml") == 1
		end,
		features = {
			lsp = { "dockerls" },
			treesitter = { "dockerfile" },
			formatters = {},
			linters = {},
		},
	},
	{
		check = function(root)
			return #vim.fn.glob(root .. "/astro.config.*", false, true) > 0
		end,
		features = {
			lsp = { "astro" },
			treesitter = {},
			formatters = {},
			linters = {},
		},
	},
	{
		check = function(root)
			return vim.fn.filereadable(root .. "/angular.json") == 1
		end,
		features = {
			lsp = { "angularls" },
			treesitter = {},
			formatters = {},
			linters = {},
		},
	},
}

local function find_project_root()
	local markers = { ".mise.toml", "mise.toml", ".tool-versions" }
	local dir = vim.fn.getcwd()
	local depth = 0

	while dir ~= "/" and depth < 10 do
		for _, marker in ipairs(markers) do
			if vim.fn.filereadable(dir .. "/" .. marker) == 1 then
				return dir
			end
		end
		local parent = vim.fn.fnamemodify(dir, ":h")
		if parent == dir then
			break
		end
		dir = parent
		depth = depth + 1
	end

	return vim.fn.getcwd()
end

local function parse_mise_toml(path)
	local tools = {}
	local file = io.open(path, "r")
	if not file then
		return tools
	end

	local in_tools = false
	for line in file:lines() do
		line = line:gsub("#.*$", ""):gsub("%s+$", "")
		if line:match("^%[tools%]") then
			in_tools = true
		elseif line:match("^%[") then
			in_tools = false
		elseif in_tools and line ~= "" then
			local key, value = line:match('^([%w][%w%-_.]*)%s*=%s*["\']([^"\']*)["\']')
			if key then
				tools[key:lower()] = value
			end
		end
	end

	file:close()
	return tools
end

local function parse_tool_versions(path)
	local tools = {}
	local file = io.open(path, "r")
	if not file then
		return tools
	end

	for line in file:lines() do
		line = line:gsub("#.*$", ""):gsub("%s+$", "")
		if line ~= "" then
			local key, value = line:match("^(%S+)%s+(%S+)")
			if key then
				tools[key:lower()] = value
			end
		end
	end

	file:close()
	return tools
end

local function read_tools_from_files(root)
	for _, name in ipairs({ ".mise.toml", "mise.toml" }) do
		local path = root .. "/" .. name
		if vim.fn.filereadable(path) == 1 then
			return parse_mise_toml(path)
		end
	end

	local tv = root .. "/.tool-versions"
	if vim.fn.filereadable(tv) == 1 then
		return parse_tool_versions(tv)
	end

	return {}
end

local function get_tools_via_cli(root)
	if vim.fn.exepath("mise") == "" then
		return nil
	end

	local result = vim.fn.system(
		string.format("cd %s && mise ls --current --json 2>/dev/null", vim.fn.shellescape(root))
	)

	if vim.v.shell_error ~= 0 or result == "" or result == "null\n" then
		return nil
	end

	local ok, data = pcall(vim.json.decode, result)
	if not ok or type(data) ~= "table" then
		return nil
	end

	local tools = {}
	for _, item in ipairs(data) do
		local name = item.tool or item.tool_name or item.name
		if name and item.active ~= false then
			tools[name:lower()] = item.version or "latest"
		end
	end

	return next(tools) ~= nil and tools or nil
end

local function unique_insert(list, value)
	for _, v in ipairs(list) do
		if v == value then
			return
		end
	end
	table.insert(list, value)
end

local function merge_features(acc, features)
	for _, server in ipairs(features.lsp or {}) do
		unique_insert(acc.lsp, server)
	end
	for _, lang in ipairs(features.treesitter or {}) do
		unique_insert(acc.treesitter, lang)
	end
	for ft, fmt in pairs(features.formatters or {}) do
		if not acc.formatters[ft] then
			acc.formatters[ft] = fmt
		end
	end
	for ft, linters in pairs(features.linters or {}) do
		if not acc.linters[ft] then
			acc.linters[ft] = linters
		end
	end
end

local _config = nil

function M.get_config()
	if _config then
		return _config
	end

	local root = find_project_root()
	local tools = get_tools_via_cli(root) or read_tools_from_files(root)

	local config = {
		lsp = vim.deepcopy(BASE.lsp),
		treesitter = vim.deepcopy(BASE.treesitter),
		formatters = vim.deepcopy(BASE.formatters),
		linters = vim.deepcopy(BASE.linters),
	}

	for tool_name in pairs(tools) do
		local features = TOOL_MAP[tool_name]
		if type(features) == "string" then
			features = TOOL_MAP[features]
		end
		if features then
			merge_features(config, features)
		end
	end

	for _, detector in ipairs(PROJECT_DETECTORS) do
		if detector.check(root) then
			merge_features(config, detector.features)
		end
	end

	_config = config
	return config
end

function M.get_lsp_servers()
	return M.get_config().lsp
end

function M.get_treesitter_langs()
	return M.get_config().treesitter
end

function M.get_formatters()
	return M.get_config().formatters
end

function M.get_linters()
	return M.get_config().linters
end

-- Useful for :lua require('util.mise').debug() when troubleshooting
function M.debug()
	local root = find_project_root()
	local tools = get_tools_via_cli(root) or read_tools_from_files(root)
	local config = M.get_config()
	vim.print({
		root = root,
		detected_tools = tools,
		lsp = config.lsp,
		treesitter = config.treesitter,
		formatters = vim.tbl_keys(config.formatters),
		linters = vim.tbl_keys(config.linters),
	})
end

return M
