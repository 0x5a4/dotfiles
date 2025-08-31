{
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./locale.nix
  ];

  sops.secrets.nix-conf = {
    sopsFile = ../secrets/nix-conf;
    format = "binary";
    mode = "0444";
  };

  xfaf.bootconfig.enable = true;
  xfaf.nixconfig = {
    enable = true;
    extraNixConfFile = config.sops.secrets.nix-conf.path;
  };

  xfaf.sudo.enable = true;

  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";

  programs.fish.enable = true;
  users = {
    defaultUserShell = pkgs.fish;
    mutableUsers = false;
  };

  security.pam.services.swaylock = { };

  programs.yubikey-touch-detector.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
    enableSSHSupport = true;
  };

  environment.shellInit = ''
    gpg-connect-agent /bye
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    echo UPDATESTARTUPTTY | gpg-connect-agent &> /dev/null
  '';

  environment.variables = {
    NIXOS_OZONE_WL = 1;
  };
}
