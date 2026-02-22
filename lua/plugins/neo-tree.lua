-- ============================================================
-- NEO-TREE
-- Persistent file explorer sidebar.
-- Navigate with j/k, open with Enter, rename with r.
-- ============================================================
return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	config = function()
		require("neo-tree").setup({
			close_if_last_window = false,
			popup_border_style = "rounded",
			enable_git_status = false,
			enable_diagnostics = false,
			sources = { "filesystem" },
			hide_root_node = true,
			window = {
				position = "left",
				width = 35,
				mapping_options = {
					noremap = true,
					nowait = true,
				},
				mappings = {
					["<CR>"] = "open",
					["o"] = "open",
					["<C-v>"] = "open_vsplit",
					["<C-x>"] = "open_split",
					["r"] = "rename",
					["a"] = "add",
					["d"] = "delete",
					["y"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",
					["q"] = "close_window",
					["R"] = "refresh",
					["?"] = "show_help",
					["H"] = "toggle_hidden",
					["-"] = "navigate_up",
				},
			},
			filesystem = {
				filtered_items = {
					visible = false,
					hide_dotfiles = false,
					hide_gitignored = false,
				},
				follow_current_file = {
					enabled = true,
					leave_dirs_open = true,
				},
				use_libuv_file_watcher = true,
			},
			default_component_configs = {
				indent = {
					indent_size = 2,
					padding = 1,
					with_markers = true,
					indent_marker = "│",
					last_indent_marker = "└",
					highlight = "NeoTreeIndentMarker",
					with_expanders = false,
				},
				modified = {
					symbol = "●",
					highlight = "NeoTreeModified",
				},
				name = {
					trailing_slash = false,
					use_git_status_colors = false,
					highlight = "NeoTreeFileName",
				},
			},
		})

		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				require("neo-tree.command").execute({ action = "show", source = "filesystem" })
			end,
		})
	end,
}
