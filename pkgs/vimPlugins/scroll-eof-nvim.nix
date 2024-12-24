{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  pname = "scroll-eof-nvim";
  version = "0-unstable-2024-11-19";
  src = fetchFromGitHub {
    owner = "Aasim-A";
    repo = "scrollEOF.nvim";
    rev = "f0ce8b853b15edacc5380855fbfe9e606788df69";
    hash = "sha256-30Bc8HPcEsdLvoT4dsWC/gLHKGwUaxvw43ffGZW99gw=";
  };
}
