{
  plugins = {
    lualine = {
      enable = true;

      settings = {
        options = {
          disabled_filetypes = [
            "NvimTree"
          ];
        };
        sections = {
          lualine_a = [ ];
          lualine_b = [
            {
              __unkeyed-1 = "filetype";
              icon_only = true;
              separator = "";
              icon = {
                align = "right";
              };
              padding = {
                left = 1;
                right = 0;
              };
            }
            # {
            #   __unkeyed-1 = "filename";
            #   path = 1;
            #   padding = {
            #     left = 0;
            #   };
            # }
          ];
          lualine_c = [ ];
          lualine_x = [ ];
          lualine_y = [ ];
          lualine_z = [ ];
        };
        inactive_sections = {
          lualine_b = [
            {
              __unkeyed-1 = "filename";
              path = 1;
            }
          ];
        };
        lualine_c = [ ];
        lualine_x = [ ];
      };
    };
  };
}

