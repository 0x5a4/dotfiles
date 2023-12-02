{
  config,
  pkgs,
  ...
}: {
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    wev
    # media
    feh
    mpv
    # screenshot
    slurp
    grim
    # bar
    waybar
    # notification daemon
    mako
    libnotify
    # launcher
    rofi-wayland
    # locking and idle
    swayidle
    swaylock-effects
    # general purpose
    kitty
    # hyprland accessories
    hyprpaper
    xdg-desktop-portal-hyprland
    inotify-tools
    # clipboard
    wl-clipboard
  ];

  # enable pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.etc = {
    "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
      bluez_monitor.properties = {
      	["bluez5.enable-sbc-xq"] = true,
      	["bluez5.enable-msbc"] = true,
      	["bluez5.enable-hw-volume"] = true,
      	["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
      }
    '';
  };

  # swaylock pam module
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  # greetd
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd Hyprland --remember --power-shutdown 'systemctl poweroff' --power-reboot 'systemctl reboot'";
      };
    };
  };
}
