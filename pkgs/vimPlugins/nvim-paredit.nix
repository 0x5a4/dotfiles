{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  pname = "nvim-paredit";
  version = "0-unstable-2024-10-25";
  src = fetchFromGitHub {
    owner = "julienvincent";
    repo = "nvim-paredit";
    rev = "0fadfa5cb14c4a2a8fc3e8fbd3cb72c7d5e16eda";
    hash = "sha256-yqKIc3ZYhpAg1TWB71yOGCa321eogpA6bK3KeKQJT6w=";
  };
}
