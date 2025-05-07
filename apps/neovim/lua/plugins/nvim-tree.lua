return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		nvimtree.setup({
			hijack_directories = {
				enable = false,
				auto_open = true,
			},
			view = {
				width = 50,
				relativenumber = false,
			},
			-- change folder arrow icons
			renderer = {
				indent_markers = {
					enable = true,
				},
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "", -- arrow when folder is closed
							arrow_open = "", -- arrow when folder is open
						},
					},
				},
			},
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = {
				enable = false,
			},
		})

		local api = require("nvim-tree.api")
		local view = require("nvim-tree.view")

		vim.api.nvim_create_autocmd({ "BufEnter" }, {
			pattern = "NvimTree*",
			callback = function()
				if not view.is_visible() then
					api.tree.open()
				end
			end,
		})
		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<M-b>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
		keymap.set("n", "<leader>of", function()
			api.tree.open({ find_file = true })
		end, { desc = "Open file explorer and focus on current file" })

		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
		keymap.set(
#     programs.neovim = {
#       enable = true;
#       defaultEditor = true;
#       viAlias = false;
#       vimAlias = true;
#       withNodeJs = false; # Required for some language servers
#         withPython3 = false; # Required for some plugins
#       
#       plugins = [
#           pkgs.vimPlugins.telescope-nvim
#           pkgs.vimPlugins.telescope-fzf-native-nvim
#           pkgs.vimPlugins.telescope-live-grep-args-nvim
#       ];
#         extraPackages = with pkgs; [
# # Core dependencies
#         git
#           gcc
#           ripgrep
#           unzip
#
# # LSP and tools
#           # nodejs
#           # nodePackages.npm
#
# # Optional but recommended
#           fd # Faster find alternative
#           lazygit # Git UI
#         ];
#
#       extraLuaConfig = ''
#         require("core")
#         require("config.lazy")
#             ${builtins.readFile "${self}/apps/neovim/plugins/telescope.lua"}
#         '';
#     };
# #
# # # Install a nerd font for icons
# #     fonts.fontconfig.enable = true;
# #     home.packages = with pkgs; [
# #       (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
# #     ];
#   };
			"n",
			"<leader>ef",
			"<cmd>NvimTreeFindFileToggle<CR>",
			{ desc = "Toggle file explorer on current file" }
		) -- toggle file explorer on current file
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
	end,
}
