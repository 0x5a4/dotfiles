{
  config,
  lib,
  pkgs,
  ...
}: {
  options.xfaf.tmux.enable = lib.mkEnableOption "install 0x5a4s tmux config";

  config = lib.mkIf config.xfaf.tmux.enable (let
    pane_title = pkgs.writeScriptBin "pane_title.sh" ''
      #!/usr/bin/env bash

      cd $1
      current_path="$(git rev-parse --show-toplevel 2> /dev/null || pwd)"
      trim_home="$(echo $current_path | sed "s?/home/$(whoami)\+?~?")"
      echo $trim_home | rev | cut -d/ -f1-2 | rev
    '';
  in {
    programs.tmux = {
      enable = true;
      plugins = with pkgs.tmuxPlugins; [
        yank
      ];

      mouse = true;
      extraConfig =
        /*
        tmux
        */
        ''
          set-option -g status-interval 2
          set-option -g automatic-rename on
          set-option -g automatic-rename-format '#(${pane_title} #{pane_current_path}):#{pane_current_command}'

          unbind %
          unbind '"'

          # if i use splits i will propably want the same dir
          bind b split-window -c "#{pane_current_path}"
          bind v split-window -h -c "#{pane_current_path}"

          bind g copy-mode

          # window numbering is weird
          set -g base-index 1
          set -g pane-base-index 1
          set-window-option -g pane-base-index 1

          # better yanking
          set-window-option -g mode-keys vi
          bind-key -T copy-mode-vi v send-keys -X begin-selection
          bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
          bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

          # Smart pane switching with awareness of Vim splits.
          # See: https://github.com/christoomey/vim-tmux-navigator
          is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
              | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
          bind-key -n 'M-h' if-shell "$is_vim" 'send-keys M-h'  'select-pane -L'
          bind-key -n 'M-j' if-shell "$is_vim" 'send-keys M-j'  'select-pane -D'
          bind-key -n 'M-k' if-shell "$is_vim" 'send-keys M-k'  'select-pane -U'
          bind-key -n 'M-l' if-shell "$is_vim" 'send-keys M-l'  'select-pane -R'

          bind-key -T copy-mode-vi 'M-h' select-pane -L
          bind-key -T copy-mode-vi 'M-j' select-pane -D
          bind-key -T copy-mode-vi 'M-k' select-pane -U
          bind-key -T copy-mode-vi 'M-l' select-pane -R
        '';
    };
  });
}
