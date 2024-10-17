{
  config,
  lib,
  pkgs,
  ...
}: {
  options.xfaf.git = {
    userName = lib.mkOption {
      description = "git user name";
      type = lib.types.str;
    };
    userEmail = lib.mkOption {
      description = "git user email";
      type = lib.types.str;
    };
    enable = lib.mkEnableOption "install 0x5a4s git config";
  };

  config = lib.mkIf config.xfaf.git.enable {
    home.packages = [
      pkgs.git-absorb
    ];

    programs.git = {
      inherit (config.xfaf.git) userName userEmail;
      
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

      extraConfig = {
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
        user.signingkey = "~/.ssh/key.pub";
        gpg.format = "ssh";
        commit.gpgSign = true;
        rebase.autoStash = true;
        rebase.abbreviateCommands = true;
      };

      aliases = {
        exec = "!exec ";
        make = "!exec make ";
        whoops = "commit --amend --no-edit";
        fuckup = "reset --soft HEAD~1";
        root = "rev-parse --show-toplevel";
        lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
        fpush = "push --force-with-lease";
      };
    };

    programs.gh = {
      enable = true;
      extensions = with pkgs; [
        gh-markdown-preview
      ];
    };
  };
}
