{ pkgs, ... }:
{
  extraPlugins = [ pkgs.vimPlugins.vim-hugo ];

  plugins = {
    treesitter = {
      enable = true;
      settings = {
        highlight = {
          enable = true;
          disable = [ "latex" ];
        };
        indent.enable = true;
      };
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        bash
        c
        clojure
        cmake
        cpp
        css
        diff
        dockerfile
        fennel
        fish
        git_config
        git_rebase
        gitattributes
        gitcommit
        gitignore
        html
        hyprlang
        ini
        java
        javascript
        json
        just
        kotlin
        latex
        lua
        make
        markdown
        markdown_inline
        meson
        nasm
        ninja
        nix
        perl
        python
        regex
        rust
        scss
        sql
        ssh_config
        tmux
        toml
        typescript
        vim
        vimdoc
        xml
        yaml
        zig
      ];
    };

    zig = {
      enable = true;
      settings.fmt_parse_errors = 0;
    };

    flutter-tools = {
      enable = true;
      settings.widget_guides.enabled = true;
    };
  };
}
