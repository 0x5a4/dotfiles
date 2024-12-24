{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  pname = "visual-whitespace-nvim";
  version = "0-unstable-2024-12-13";
  src = fetchFromGitHub {
    owner = "mcauley-penney";
    repo = "visual-whitespace.nvim";
    rev = "31d0ed71ad7e376879d7e0df0c8cc4f1467702d4";
    hash = "sha256-W8ZzGdm1bYNt6vUKI6WJ5zh+wL+0SXFuIp6tQun7iVA=";
  };
}
