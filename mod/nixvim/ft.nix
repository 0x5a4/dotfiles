{ ... }:
{
  filetype = {
    pattern = {
      "[Jj][Uu][Ss][Tt][Ff][Ii][Ll][Ee]" = "just";
      ".*%.[Jj][Uu][Ss][Tt][Ff][Ii][Ll][Ee]" = "just";
      ".*%.[Jj][Uu][Ss][Tt]" = "just";
    };
  };

  extraFiles = {
    "ftplugin/hdl.vim".text = ''
      setlocal commentstring=//\ %s
    '';
    "ftplugin/markdown.vim".text = ''
      setlocal spell
    '';
    "ftplugin/nix.vim".text = ''
      setlocal commentstring=#\ %s
      setlocal sw=2
    '';
    "ftplugin/zig.vim".text = ''
      setlocal commentstring=//\ %s
    '';
    "syntax/markdown.vim".text = ''
      syntax match markdownNewLine "  $" conceal cchar=⏎
    '';
  };
}
