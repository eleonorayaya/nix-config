{
  # TODO: fix tab to complete 
  plugins = {
    luasnip.enable = true;
    # copilot-lua = {
    #   enable = true;
    #   settings = {
    #     suggestion.enabled = false;
    #     panel.enabled = false;
    #     filetypes = {
    #     };
    #   };
    # };

    cmp-buffer = { enable = true; };

    cmp-emoji = { enable = true; };

    cmp-nvim-lsp = { enable = true; };

    cmp-path = { enable = true; };

    cmp_luasnip = { enable = true; };

    cmp = {
      enable = true;

      settings = {
        experimental = { ghost_text = true; };
        snippet.expand = ''
          function(args)
            require('luasnip').lsp_expand(args.body)
          end
        '';
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          {
            name = "buffer";
            option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
          }
          { name = "nvim_lua"; }
          { name = "path"; }
          # { name = "copilot"; }
        ];


        mapping = {
          "<C-j>" = "cmp.mapping.select_next_item()";
          "<C-k>" = "cmp.mapping.select_prev_item()";
          "<C-Space>" = "cmp.mapping.complete()";
          "<S-Tab>" = "cmp.mapping.close()";
        };
      };
    };
  };
}
