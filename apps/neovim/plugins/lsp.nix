{
  plugins = {
    lsp = {
      enable = true;
      servers = {
        bashls.enable = true;
        lua_ls.enable = true;
        nixd.enable = true;

        # Packages is set to null to rely on the system wide installed packages
        # this is done to avoid conflicts with the nixpkgs versions.
        gopls = {
          enable = true;
          package = null; # default pkgs.gopls
        };
      };
      keymaps.lspBuf = {
        "gd" = "definition";
        "gr" = "references";
        "gt" = "type_definition";
        "gi" = "implementation";
        "K" = "hover";
      };
    };
  };
}
