{ pkgs, ... }:
{
  extraPlugins = [
    pkgs.unstable.vimPlugins.hlchunk-nvim
  ];
  extraConfigLua = ''
    require('hlchunk').setup({
      chunk = {
        enable = true,
      },
      indent = {
        enable = false,
      },
      blank = {
        enable = false,
      },
      line_num = {
        enablechunk = true,
        use_treesitter = true,
      },
    })
  '';
}
