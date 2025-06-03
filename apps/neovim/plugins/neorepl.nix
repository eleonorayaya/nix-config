{ pkgs, ... }:
{
  extraPlugins = [
    pkgs.vimPlugins.neorepl-nvim
  ];
  extraConfigLua = ''
    vim.keymap.set('n', '<leader>rr', function()
      vim.cmd('split')

      -- spawn repl and set the context to our buffer
      require('neorepl').new{
        lang = 'lua',
      }
      -- resize repl window and make it fixed height
      vim.cmd('resize 10 | setl winfixheight')
    end)
  '';
}
