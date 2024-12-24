{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  pname = "vim-indent-object";
  version = "0-unstable-2023-04-01";
  src = fetchFromGitHub {
    owner = "phelipetls";
    repo = "vim-hugo";
    rev = "324fb8c7371d31701349c1192e25a0bdcf9898f8";
    hash = "sha256-RCHPhTMuShFAU3SXLu3CBdHd27oXgYG6JO/qrJfisUw=";
  };
}
