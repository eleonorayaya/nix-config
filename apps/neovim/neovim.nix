_: {
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
      {
        key = "<M-b>";
        mode = "n";
        action = "<cmd>NvimTreeToggle<CR>";
      }

      # Telescope
      {
        key = "<M-p>";
        mode = "n";
        action .__raw= ''
          function()          
            local function is_git_repo()
              vim.fn.system("git rev-parse --is-inside-work-tree")
              return vim.v.shell_error == 0
            end

            local function get_git_root()
              local dot_git_path = vim.fn.finddir(".git", ".;")
              return vim.fn.fnamemodify(dot_git_path, ":h")
            end

            local opts = {}
            if is_git_repo() then
              opts = {
                cwd = get_git_root(),
              }
            end

            require("telescope.builtin").find_files(opts)
          end
          '';

      }
    ];
  };
}
