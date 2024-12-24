{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  pname = "antonys-macro-repeater";
  version = "0-unstable-2024-09-10";
  src = fetchFromGitHub {
    owner = "ckarnell";
    repo = "Antonys-macro-repeater";
    rev = "61784d86b2654f3e261b9cc33360c5197704e266";
    hash = "sha256-nK53ppPJWCChRVRAay/vb5DanFjrOBF00rIvHBLIBbM=";
  };
}
