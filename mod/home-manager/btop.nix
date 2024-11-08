{
  config,
  lib,
  ...
}:
{
  options.xfaf.btop.enable = lib.mkEnableOption "install 0x5a4s btop config";

  config = lib.mkIf config.xfaf.btop.enable {
    programs.btop = {
      enable = true;
      settings = {
        vim_keys = true;
        proc_sorting = "cpu lazy";
        proc_per_core = true;
      };
    };
  };
}
