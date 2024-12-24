{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  pname = "alternate-toggler";
  version = "0-unstable-2024-06-04";
  src = fetchFromGitHub {
    owner = "rmagatti";
    repo = "alternate-toggler";
    rev = "819800304d3e8e575fd6aa461a8bcf2217e1cfb6";
    hash = "sha256-+UXbgVRki1CGRDHRNrnXOIvzr+0lCAftzGsGVzVQwL4=";
  };
}
