{ pkgs
, ...
}:
let
  helpers = import ../../lib/helpers.nix { inherit pkgs; };
  pluginNixFiles = helpers.filterLs ./plugins "nix";

  configLuaContent = helpers.concatLs ./lua "lua";
  pluginLuaContent = helpers.concatLs ./lua/plugins "lua";
in
{
  programs.nixvim = {
    enable = true;

    globals.mapleader = " ";

    imports = [
      ./options.nix
    ] ++ pluginNixFiles;

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "frappe";
        transparent_background = true;

        integrations = {
          nvimtree = true;
        };
      };
    };

    keymaps = [
      # Comment
      {
        key = "<C-_>";
        mode = "n";
        action.__raw = "comment_toggle_line";
      }
      {
        key = "<C-_>";
        mode = "x";
        action.__raw = "comment_toggle_selection";
      }

      # Harpoon
      {
        key = "<leader>a";
        mode = "n";
        action.__raw = "harpoon_add_file";
      }
      {
        key = "<C-o>";
        mode = "n";
        action.__raw = "harpoon_open_telescope_marks";
      }

      # Nvim Tree
      {
        key = "<M-b>";
        mode = "n";
        action.__raw = "nvim_tree_toggle";
      }
      {
        key = "<leader>of";
        mode = "n";
        action.__raw = "nvim_tree_reveal_current_file";
      }

      # Telescope
      {
        key = "<M-p>";
        mode = "n";
        action .__raw = "telescope_pick_project_files";

      }
      {
        key = "<leader>ff";
        mode = "n";
        action.__raw = "telescope_live_grep";
      }

      # Window Mgmt
      {
        key = "<M-k>";
        mode = "n";
        action = "<cmd>vsplit<cr>";
      }
    ];

    extraConfigLuaPre = ''
      ${configLuaContent}
      ${pluginLuaContent}
    '';
  };
}
