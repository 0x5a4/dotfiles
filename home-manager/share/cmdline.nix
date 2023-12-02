{
  config,
  pkgs,
  ...
}: {
  # neovim
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.withPython3 = true;
  programs.neovim.viAlias = true;
  
  home.packages = with pkgs; [
    fish
    gnumake
    rcm
    
    alejandra
    
    eza
    wget
    git
    delta
    bat
    tmux
    starship
    btop
    psmisc
    direnv
    fzf
    rustup

    fastfetch
  ];
}
