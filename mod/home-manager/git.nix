{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.xfaf.git.enable = lib.mkEnableOption "install 0x5a4s git config";

  config = lib.mkIf config.xfaf.git.enable {
    home.packages = with pkgs; [
      git-absorb
      gh
    ];

    programs.git =
      let
        keySelector = pkgs.writers.writeBashBin "select-ssh-sign-key" ''
          echo key::$(ssh-add -L)
        '';
      in
      {
        userName = "0x5a4";
        userEmail = "1444@wienstroer.net";

        enable = true;

        lfs.enable = true;

        delta = {
          enable = true;
          options = {
            navigate = true;
            light = false;
            line-numbers = true;
            line-numbers-left-format = "{nm:>4} │";
            colorMoved = "default";
          };
        };

        attributes = [
          "* text=auto"
        ];

        signing = {
          format = "ssh";
          signByDefault = true;
        };

        extraConfig = {
          gpg.ssh.defaultKeyCommand = lib.getExe keySelector;
          core = {
            whitespace = "trailing-space,space-before-tab";
            eol = "lf";
          };
          pull.rebase = true;
          push.followTags = true;
          push.autoSetupRemote = true;
          feature.manyFiles = true;
          init.defaultBranch = "main";
          column.ui = "auto";
          merge.conflictstyle = "diff3";
          diff.colorMoved = "default";
          advice.addEmptyPathspec = false;
          commit.gpgSign = true;
          rebase.autoStash = true;
          rebase.abbreviateCommands = true;
          rerere.enabled = true;
          branch.sort = "-committerdate";
        };

        aliases = {
          exec = "!exec ";
          make = "!exec make ";
          fuckup = "reset --soft HEAD~1";
          root = "rev-parse --show-toplevel";
          lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
          fpush = "push --force-with-lease";
          smartblame = "blame -w -CCC";
        };
      };
  };
}
