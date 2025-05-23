{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Fonts
    dejavu_fonts
    font-awesome
    hack-font
    meslo-lgs-nf
    noto-fonts
    noto-fonts-emoji
    sketchybar-app-font

    # Media Tools
    ffmpeg
    iina
    jpegoptim
    pngquant

    # Nix Configuration
    nil

    # Node.js Development
    nodePackages.npm
    # nodePackages.prettier
    nodejs

    # Python Development
    # python3
    # uv

    # Security Tools
    openssh

    # Software Development
    # act
    # difftastic
    # docker
    # docker-client
    # docker-compose
    # flyctl
    gcc
    # gh
    git
    git-credential-manager
    gnugrep
    # go
    # gopls
    # ngrok

    # System Management
    bat
    btop
    coreutils
    defaultbrowser
    du-dust
    fastfetch
    fd
    fzf
    iftop
    jq
    kitty
    lsd
    mkalias
    oh-my-posh
    ripgrep
    syncthing
    tree
    unrar
    unzip
    wget
    wireshark
    zip
    zsh

    # System UI
    aerospace
    jankyborders
    sketchybar

    # Text Editors
    vim
    
    # Terminal
    neofetch
    tmux
    tmux-sessionizer
  ];
}
