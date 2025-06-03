{ pkgs, ... }:
{
  extraPlugins = [
    pkgs.vimPlugins.which-key-nvim
  ];
  extraConfigLua = ''
    require('which-key').setup({
      preset = "helix"
    });
  '';
}
