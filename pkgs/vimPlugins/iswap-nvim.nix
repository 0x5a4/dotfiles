{
  fetchFromGitHub,
  vimPlugins,
  vimUtils,
}:
vimUtils.buildVimPlugin {
  pname = "iswap-nvim";
  version = "0-unstable-2024-05-23";
  src = fetchFromGitHub {
    owner = "mizlan";
    repo = "iswap.nvim";
    rev = "e02cc91f2a8feb5c5a595767d208c54b6e3258ec";
    hash = "sha256-lAYHvz23f9nJ6rb0NIm+1aq0Vr0SwjPVitPuROtUS2A=";
  };

  nativeBuildInputs = [
    vimPlugins.nvim-treesitter
  ];
}
