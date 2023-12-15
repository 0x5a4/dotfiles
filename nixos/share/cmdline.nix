{
  config,
  pkgs,
  ...
}: {
  programs.fish.enable = true;

  environment.shellAliases = {
    ls = null;
    ll = null;
    l = null;
  };

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.withPython3 = true;
  programs.neovim.viAlias = true;

  environment.systemPackages = with pkgs; [
    fish
    gnumake
    rcm

    alejandra
    marksman

    acpi
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
    duf
    fd
    ripgrep
    speedtest-rs
    fastfetch
    nodejs_20
    gcc
    python3
    clang
    sops
    jq
    unzip
    file
    mdcat
  ];
}
