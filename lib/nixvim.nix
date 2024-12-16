{ lib, ... }:
let
  noremap' = mode: key: action: {
    inherit mode key action;
    options = {
      noremap = true;
      silent = true;
    };
  };
in
{
  inherit noremap';

  keyBindsFromAttrs = bindFn: attrs: lib.mapAttrsToList (n: v: bindFn n v) attrs;

  noremap = noremap' "";
  nnoremap = noremap' "n";
  inoremap = noremap' "i";
  xnoremap = noremap' "x";
  onoremap = noremap' "o";
  snoremap = noremap' "s";
  #                    nixos lmao
}
