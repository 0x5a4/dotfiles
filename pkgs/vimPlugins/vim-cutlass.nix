{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  pname = "vim-cutlass";
  version = "0-unstable-2020-03-01";
  src = fetchFromGitHub {
    owner = "svermeulen";
    repo = "vim-cutlass";
    rev = "7afd649415541634c8ce317fafbc31cd19d57589";
    hash = "sha256-j5W9q905ApDf3fvCIS4UwyHYnEZu5Ictn+6JkV/xjig=";
  };
}
