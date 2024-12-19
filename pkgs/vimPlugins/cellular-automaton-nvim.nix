{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  pname = "cellular-automaton-nvim";
  version = "0-unstable-2024-06-30";
  src = fetchFromGitHub {
    owner = "Eandrju";
    repo = "cellular-automaton.nvim";
    rev = "11aea08aa084f9d523b0142c2cd9441b8ede09ed";
    hash = "sha256-nIv7ISRk0+yWd1lGEwAV6u1U7EFQj/T9F8pU6O0Wf0s=";
  };
}
