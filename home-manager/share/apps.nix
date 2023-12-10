{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    webcord-vencord
    spotify
    prismlauncher
  ];
}
