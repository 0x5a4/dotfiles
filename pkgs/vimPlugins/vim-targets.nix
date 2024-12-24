{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  pname = "vim-targets";
  version = "0-unstable-2024-07-10";
  src = fetchFromGitHub {
    owner = "wellle";
    repo = "targets.vim";
    rev = "6325416da8f89992b005db3e4517aaef0242602e";
    hash = "sha256-ThfL4J/r8Mr9WemSUwIea8gsolSX9gabJ6T0XYgAaE4=";
  };
}
