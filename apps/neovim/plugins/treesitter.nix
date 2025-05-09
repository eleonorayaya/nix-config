{
  plugins = {
    treesitter = {
      enable = true;

      settings = {
        highlight.enable = true;
        indent.enable = true;
        autotag.enable = true;
      };
    };

    ts-autotag = {
      enable = true;
    };
  };
}
