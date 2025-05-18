{
  plugins = {
    telescope = {
      enable = true;

      extensions = {
        # cmdline = {
        #   enable = true;
        # };

        fzf-native = {
          enable = true;
        };

        live-grep-args = {
          enable = true;

          settings = {
            auto_quoting = true;
            mappings = {
              i = {
                "<C-i>".__raw = ''
                  require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --iglob " })
                '';
              };
            };
          };
        };
      };

      settings = {
        defaults = {
          layout_config = {
            horizontal = {
              prompt_position = "top";
              preview_width = 0.55;
            };
            width = 0.87;
            height = 0.80;
          };
          mappings = {
            i = {
              "<C-k>".__raw = "require('telescope.actions').move_selection_previous";
              "<C-j>".__raw = "require('telescope.actions').move_selection_next";
            };
          };
        };
      };

      keymaps = {
        "<leader>fa" = {
          mode = "n";
          action = "find_files";

        };
      };
    };
  };
}
