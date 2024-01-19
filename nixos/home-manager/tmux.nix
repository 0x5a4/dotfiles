{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.file = {
    ".config/tmux/pane_title.sh".source = ../../config/tmux/pane_title.sh;
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    plugins = with pkgs; [
      tmuxPlugins.yank
      {
        plugin = tmuxPlugins.dracula;
        extraConfig = ''
          set -g @dracula-show-powerline true
          set -g @dracula-plugins "ssh-session attached-clients time"
          set -g @dracula-show-left-icon @
        '';
      }
      tmuxPlugins.dracula
    ];
    extraConfig = builtins.readFile ../../config/tmux/tmux.conf;
  };
}
