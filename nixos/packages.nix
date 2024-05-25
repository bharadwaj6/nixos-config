{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    htop
    jq
    tmux
    yq
    ripgrep
    ncdu
    nix-tree
    vscode
    nil # LSP for vscode
    bat
    eza
    git
    git-lfs
    gh
    lf
    nurl
    comma
    alejandra
    ollama

    # other packages
    obs-studio
    discord
    neovim
    spotify
    jetbrains.pycharm-community
    signal-desktop
    whatsapp-for-linux
    vlc
  ];
}
