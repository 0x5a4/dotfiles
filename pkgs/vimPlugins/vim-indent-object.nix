{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  pname = "vim-indent-object";
  version = "0-unstable-2024-01-24";
  src = fetchFromGitHub {
    owner = "michaeljsmith";
    repo = "vim-indent-object";
    rev = "8ab36d5ec2a3a60468437a95e142ce994df598c6";
    hash = "sha256-fIqe85gstH9KEXrXPHdsSI3KgPYs5wDtufYKHFXKaxE=";
  };
}
