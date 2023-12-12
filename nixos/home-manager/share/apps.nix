{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    webcord
    spotify
    prismlauncher
  ];
}
