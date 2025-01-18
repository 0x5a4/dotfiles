{
  pkgs,
  lib,
  ...
}:
with lib.xfaf.nixvim;
with lib.nixvim;
{
  extraPlugins = [ pkgs.vimPlugins.vim-hugo ];

  plugins = {
    treesitter = {
      enable = true;
      settings = {
        highlight = {
          enable = true;
          disable = [
            "markdown"
            "markdown_inline"
            "latex"
          ];
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
      lazyLoad = {
        enable = true;
        settings.event = "User File";
      };
    };

    zig = {
      enable = true;
      settings.fmt_parse_errors = 0;
    };
  };
}
