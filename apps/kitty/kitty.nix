{ config
, user
, pkgs
, ...
}: {
  config = {
    home-manager.users.${user.username} = {
      home.file = { };
      programs.kitty = {
        enable = true;
        font = {
          name = "JetBrainsMono Nerd Font";
          size = 16.0;
        };
        settings = {
          scrollback_lines = 10000;
          enable_audio_bell = false;
          background_opacity = 0.75;
          background_blur = 64;
          window_padding_width = 20;
          hide_window_decorations = "titlebar-only";

          allow_remote_control = true;
          confirm_os_window_close = 0;

          # cursor
          cursor_shape = "underline";
          cursor_trail = 4;
          cursor_blink_interval = 0;

          # tabs
          tab_bar_style = "custom";
          tab_bar_edge = "top";
          tab_bar_align = "left";
          tab_powerline_style = "slanted";
          active_tab_font_style = "italic";
          tab_title_template = "[{index}] {title}";
          active_tab_title_template = "[{index}] {title}";

          # font
          bold_font = "auto";
          italic_font = "auto";
          bold_italic_font = "auto";

          # shell
          shell_integration = "enabled";
        };
        keybindings = {
          "cmd+k" = "";
        };
        themeFile = "catppuccin-frappe";
        extraConfig = ''
          # Enable ligatures
          font_features JetBrainsMonoNerdFontComplete-Regular +liga +calt
          font_features JetBrainsMonoNerdFontComplete-Bold +liga +calt
          font_features JetBrainsMonoNerdFontComplete-Italic +liga +calt
          font_features JetBrainsMonoNerdFontComplete-BoldItalic +liga +calt
        '';
      };

      home.file = {
        ".config/kitty/themes/catppuccin-frappe.conf" = {
          source = pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/catppuccin/kitty/main/themes/frappe.conf";
            hash = "sha256-boYuT8Ptiy1598hptuKX88lKOIbixOAwCvGX6ln92iQ=";
          };
        };
      };
    };
  };
}
