_: 
let
  lua_files = builtins.map (name: ./lua + "/${name}")
    (builtins.filter (name: builtins.match ".*\\.lua" name != null)
      (builtins.attrNames (builtins.readDir ./lua)));

  plugin_files = builtins.map (name: ./lua/plugins + "/${name}")
    (builtins.filter (name: builtins.match ".*\\.lua" name != null)
      (builtins.attrNames (builtins.readDir ./lua/plugins)));

  lua_content = builtins.concatStringsSep "\n" (
   builtins.map (filename: builtins.readFile filename) lua_files
  );

  plugin_content = builtins.concatStringsSep "\n" (
   builtins.map (filename: builtins.readFile filename) plugin_files
  );
in 
{
  programs.nixvim = {
    enable = true;

    globals.mapleader = " ";

    imports = builtins.map (name: ./plugins + "/${name}")
      (builtins.filter (name: builtins.match ".*\\.nix" name != null)
        (builtins.attrNames (builtins.readDir ./plugins)));

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "frappe";

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
      ${lua_content}
      ${plugin_content}
    '';
  };
}
