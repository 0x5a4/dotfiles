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

  veryLazyEvent = "User DeferredUIEnter";

  keyBindsFromAttrs = bindFn: attrs: lib.mapAttrsToList (n: v: bindFn n v) attrs;
  lazyKeyBindsOf = lib.map (
    bind:
    {
      inherit (bind) mode;
      __unkeyed-1 = bind.key;
      __unkeyed-2 = bind.action;
    }
    // bind.options
  );

  noremap = noremap' "";
  nnoremap = noremap' "n";
  inoremap = noremap' "i";
  xnoremap = noremap' "x";
  onoremap = noremap' "o";
  snoremap = noremap' "s";
  #                    nixos lmao
  nxonoremap = noremap' [
    "n"
    "x"
    "o"
  ];
}
