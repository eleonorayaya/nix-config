{ pkgs, ... }:
{
  extraPlugins = [
    pkgs.vimPlugins.searchbox-nvim
  ];
  extraConfigLua = ''
    require('searchbox').setup({

    })

    vim.keymap.set('n', '<leader>s', ':SearchBoxIncSearch<CR>')
  '';
}
