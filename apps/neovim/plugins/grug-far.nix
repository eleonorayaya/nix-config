{ pkgs, ... }:
{
  extraPlugins = [
    pkgs.vimPlugins.grug-far-nvim
  ];
  extraConfigLua = ''
    require('grug-far').setup({})

    vim.keymap.set('n', '<leader>fr', function()
      require('grug-far').open({ 
        prefills = { 
          search = vim.fn.expand("<cword>")
        } 
      })
    end)

    vim.keymap.set('x', '<leader>fr', function()
      require('grug-far').open({ 
        prefills = { 
          search = vim.fn.expand("<cword>")
        } 
      })
    end)
  '';
}
