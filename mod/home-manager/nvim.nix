{
  lib,
  config,
  outputs,
  pkgs,
  ...
}:
{
  options.xfaf.neovim = {
    enable = lib.mkEnableOption "install 0x5a4s neovim config";
    makeDefault = lib.mkEnableOption "make neovim the default editor";
  };

  config =
    let
      opts = config.xfaf.neovim;
    in
    lib.mkIf opts.enable {
      xdg.mimeApps = {
        enable = true;
        defaultApplications = lib.mkIf opts.makeDefault {
          "text/plain" = "neovim.desktop";
        };
      };

      home.packages = [ outputs.packages.${pkgs.stdenv.system}.nixvim ];

      home.sessionVariables.EDITOR = lib.mkIf opts.makeDefault "nvim";

      home.file = {
        ".config/zathura/zathurarc".text = ''
          set render-loading false
        '';
      };
    };
}
