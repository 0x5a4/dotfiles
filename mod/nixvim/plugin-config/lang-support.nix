{
  pkgs,
  xfaf-lib,
  lib,
  ...
}:
with xfaf-lib.nixvim;
with lib.nixvim;
{
  extraPlugins = [ pkgs.vimPlugins.vim-hugo ];

  plugins = {
    treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
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
        gitattributes
        gitcommit
        git_config
        gitignore
        git_rebase
        html
        hyprlang
        ini
        java
        javascript
        json
        just
        kotlin
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
