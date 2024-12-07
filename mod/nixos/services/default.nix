{ ... }:
{
  imports = [
    ./avahi.nix
    ./greetd.nix
    ./opensssh.nix
    ./pipewire.nix
    ./tailscale.nix
    ./tlp.nix
    ./traefik.nix
    ./vaultwarden
    ./wifi.nix
  ];
}
