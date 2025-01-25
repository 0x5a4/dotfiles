{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = lib.xfaf.importAllChildren ./.;

  options.xfaf.shell = {
    enableAliases = lib.mkEnableOption "enable 0x5a4s shell aliases";
    installTools = lib.mkEnableOption "install a bunch of very useful commandline tools";
    saneEnv = lib.mkOption {
      description = "set up sane environment variables";
      type = lib.types.bool;
      default = true;
    };
  };

  config = {
    home.sessionVariables = lib.mkIf config.xfaf.shell.saneEnv {
      GOPATH = config.home.homeDirectory + "/.go";
    };

    xdg.enable = config.xfaf.shell.saneEnv;

    home.packages = lib.mkIf config.xfaf.shell.installTools (
      with pkgs;
      [
        acpi
        bat
        duf
        dust
        eza
        fastfetch
        fd
        file
        imagemagick
        jq
        man-pages-posix
        mdcat
        psmisc
        ripgrep
        speedtest-rs
        unzip
        wget
        xxd
      ]
    );

    home.shellAliases = lib.mkIf config.xfaf.shell.enableAliases rec {
      # ls stuff
      ls = "${lib.getExe pkgs.eza} -F --sort extension --group-directories-first --git --icons -Mo --hyperlink --git-repos-no-status --color-scale=size --no-permissions ";
      ll = ls + "-l ";
      la = ll + "-a ";
      l = ll;
      gls = ll + "--git-ignore ";
      # tree fake
      tree = ls + "--tree ";
      ltree = ll + "--tree ";
      gtree = ltree + "--git-ignore ";
      tree2 = tree + "--level=2 ";
      tree3 = tree + "--level=3 ";
      # convenience
      cat = lib.getExe pkgs.bat;
      ccat = "command cat";
      lsblk = "command lsblk -f";
      mkdirp = "mkdir -p";
      rm = "rm -Iv";
      df = lib.getExe pkgs.duf;
      cp = lib.getExe pkgs.xcp;
      # git
      gs = "${lib.getExe pkgs.git} status -sb";
      gd = "${lib.getExe pkgs.git} diff";
      gdc = "${lib.getExe pkgs.git} diff --cached";
      ga = "${lib.getExe pkgs.git} add";
      gaa = "${lib.getExe pkgs.git} add --all";
      gl = "${lib.getExe pkgs.git} lg";
      gcm = "${lib.getExe pkgs.git} commit -m";
    };
  };
}
