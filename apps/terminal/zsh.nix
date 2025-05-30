{ pkgs
, user
, ...
}: {
  home-manager.users.${user.username} = _: {
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;

      shellAliases = {
        c = "clear";
        cat = "bat";
        diff = "difft";
        du = "dust";
        find = "fd";
        ls = "lsd";
        ll = "ls -la";
        fetch = "fastfetch";
        top = "btop";
        update = "darwin-rebuild switch --flake /etc/nix-darwin";
        vim = "nvim";

        # git
        gittouch = "git pull --rebase && git commit -m 'touch' --allow-empty && git push";
        gsu = "git status -uno";

        tf = "terraform";
        tfmt = "terraform fmt -recursive";
      };

      plugins = [
        {
          name = "oh-my-posh";
          src = pkgs.oh-my-posh;
        }
        {
          name = "vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
      ];

      dirHashes = {
        idrive = "$HOME/Library/Mobile Documents/com~apple~CloudDocs";
      };

      history = {
        ignorePatterns = [
          "pwd"
          "ls *"
          "cd *"
        ];
      };

      sessionVariables = {
        # FZF_DEFAULT_OPTS = builtins.concatStringsSep " " [
        #   "--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284"
        #   "--color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf"
        #   "--color=marker:#babbf1,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"
        #   "--color=selected-bg:#51576d"
        #   "--color=border:#414559,label:#c6d0f"
        # ];
      };

      completionInit = ''
        # Case insensitive matching for completion with smart case behavior
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      '';

      initExtra = ''
        eval "$(oh-my-posh init zsh --config ${pkgs.oh-my-posh}/share/oh-my-posh/themes/catppuccin_frappe.omp.json)"
        . ~/.zsh/helpers/index.zsh

        fastfetch
      '';
    };
  };
}
