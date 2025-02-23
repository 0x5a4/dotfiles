{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  pname = "stay-in-place";
  version = "1.0.0";
  src = fetchFromGitHub {
    owner = "gbprod";
    repo = "stay-in-place.nvim";
    rev = "v1.0.0";
    hash = "sha256-Cq9/JQoxuUiAQPobiSizwmvdxJRjE7XjG47A38wdVwY=";
  };
}
