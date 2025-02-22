{ lib, ... }:
lib.nixvim.plugins.neovim.mkNeovimPlugin {
  name = "cheatsheet";
  package = "cheatsheet-nvim";
  maintainers = [ ];

  extraOptions = {
    cheatsheet = lib.mkOption {
      type = with lib.types; attrsOf (attrsOf str);
    };
  };

  extraConfig = cfg: {
    extraFiles."cheatsheet.txt".text = lib.foldlAttrs (
      acc: sectionName: sectionValue:
      acc
      + ''
        ## ${sectionName}
        ${lib.pipe sectionValue [
          (lib.mapAttrsToList (what: desc: "${desc} | ${what}"))
          (lib.concatStringsSep "\n")
        ]}
      ''
    ) "" cfg.cheatsheet;
  };
}
