{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  pname = "numbers-nvim";
  version = "0-unstable-2022-7-11";
  src = fetchFromGitHub {
    owner = "h-hg";
    repo = "numbers.nvim";
    rev = "efe6cf60755c9f7cf1cfac03f38a0fa7f6e63fdd";
    hash = "sha256-Oh7r06C659MB/aYR/I/ZBDtYZ0O9+5ZVUqsybYLpBro=";
  };
}
