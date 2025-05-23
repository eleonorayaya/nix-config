{ pkgs
, user
, theme
, ...
}:
let
  themePlugins = with pkgs.tmuxPlugins; {
    catppuccin-frappe = {
      plugin = catppuccin;
      extraConfig = ''
        set -g @catppuccin_flavor "frappe"
        set -g @catppuccin_window_status_style "rounded"

        set -g status-right-length 100
        set -g status-left-length 100
        set -g status-left ""
        set -g status-right "#{E:@catppuccin_status_session}"
      '';
    };

    rose-pine-moon = {
      plugin = rose-pine;
      extraConfig = ''
        set -g @rose_pine_variant 'moon'

      '';
    };
  };

  themePlugin = themePlugins.${theme.name};
in
{
  home-manager.users.${user.username} = _: {
    programs.tmux = {
      enable = true;
      clock24 = true;
      mouse = true;
      shell = "${pkgs.zsh}/bin/zsh";
      terminal = "tmux-256color";
      keyMode = "vi";

      plugins = with pkgs.tmuxPlugins; [
        themePlugin
        {
          plugin = vim-tmux-navigator;
        }
        {
          plugin = resurrect;
        }
        {
          plugin = continuum;
        }
      ];

      extraConfig = ''
        set -g repeat-time 750 
        set-option -sg escape-time 10
        set -g mouse on   

        unbind d
        unbind D

        bind d split-window -h
        bind D split-window -v
        unbind '"'
        unbind %

        bind-key -r -T prefix h resize-pane -L 5
        bind-key -r -T prefix j resize-pane -D 5
        bind-key -r -T prefix k resize-pane -U 5
        bind-key -r -T prefix l resize-pane -R 5

        bind-key -r -T prefix p  display-popup -E "tms switch"
        bind-key -r -T prefix P  display-popup -E "tms"

        set-option -g default-command "${pkgs.zsh}/bin/zsh"

        # Add padding above status bar
        set -g status 2
        run-shell "tmux set-option -g status-format[1] '#{status-format[0]}'"
        set -g status-format[0] ' '

        set -g @continuum-restore 'on'
        set -g @resurrect-strategy-nvim 'session'
        set -g @continuum-save-interval '1'
        set -g @resurrect-processes '~zsh'
      '';
    };
  };
}
