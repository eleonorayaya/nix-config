{ user
, pkgs
, theme
, ...
}:
let
  themeConfigs = {
    catppuccin-frappe = {
      url = "https://raw.githubusercontent.com/catppuccin/kitty/main/themes/frappe.conf";
      hash = "sha256-boYuT8Ptiy1598hptuKX88lKOIbixOAwCvGX6ln92iQ=";
    };

    rose-pine-moon = {
      url = "https://raw.githubusercontent.com/rose-pine/kitty/refs/heads/main/dist/rose-pine-moon.conf";
      hash = "sha256-ivIvhG2/duKfUXeJqcYfGnlKzpR5bxhV0+R3FT6AF64=";
    };
  };

  themeConfig = themeConfigs.${theme.name};
in
{
  config = {
    home-manager.users.${user.username} = {
      programs.kitty = {
        enable = true;
        font = {
          name = "Liga SFMono Nerd Font";
          size = 18.0;
        };
        settings = {
          scrollback_lines = 10000;
          enable_audio_bell = false;
          background_opacity = 0.75;
          background_blur = 48;
          window_padding_width = 20;
          hide_window_decorations = "titlebar-only";

          allow_remote_control = true;
          confirm_os_window_close = 0;

          # cursor
          cursor_shape = "underline";
          cursor_trail = 0;
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

          open_url_with = "default";
          mouse_map = "ctrl+left press grabbed,ungrabbed mouse_handle_click link";
        };
        keybindings = {
          "cmd+k" = "";
        };
        themeFile = theme.name;
        extraConfig = ''
          # Enable ligatures
          font_features SFMono-Nerd-Font-Ligaturized-Regular +liga +calt
          font_features SFMono-Nerd-Font-Ligaturized-Bold +liga +calt
          font_features SFMono-Nerd-Font-Ligaturized-Italic +liga +calt
          font_features SFMono-Nerd-Font-Ligaturized-BoldItalic +liga +calt
        '';
      };

      home.file = {
        ".config/kitty/themes/${theme.name}.conf" = {
          source = pkgs.fetchurl themeConfig;
        };
      };
    };
  };
}
