{
  plugins = {
    nvim-tree = {
      enable = true;

      openOnSetupFile = true;
      autoReloadOnWrite = true;

      hijackUnnamedBufferWhenOpening = true;

      hijackDirectories = {
        enable = false;
        autoOpen = true;
      };

      renderer = {
        indentMarkers = {
          enable = false;
        };

        icons = {
          glyphs = {
            folder = {
              arrowClosed = "";
              arrowOpen = "";
            };
          };
        };
      };

      actions = {
        windowPicker = {
          enable = false;
        };
      };

      filters = {
        exclude = [
          ".DS_Store"
        ];
      };

      git = {
        enable = false;
      };
    };

    web-devicons = { enable = true; };
  };
}
