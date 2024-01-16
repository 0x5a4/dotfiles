{
  config,
  pkgs,
  ...
}: {
  programs.hyprland.enable = true;

  programs.steam.enable = true;

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
    #rofi-wayland-unwrapped
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
    # polkit agent
    polkit_gnome
    # greeter
    greetd.regreet
    #gtk theme
    dracula-theme
    # media control
    playerctl
    # backlight
    acpilight

    wob
    batsignal
    xdg-utils
    rofi-bluetooth

    webcord
    spotify
    prismlauncher
    thunderbird

    (retroarch.override {
      cores = with libretro; [
      ];
    })
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
      auth sufficient pam_fprintd.so
      auth include login
    '';
  };

  # greetd
  programs.regreet = {
    enable = true;
    settings = builtins.fromTOML ''
      [background]
      path = "/etc/greetd/background.jpg"
      fit = "Fill"

      [env]

      [GTK]
      cursor_theme_name = "Dracula"
      font_name = "Cantarell 16"
      icon_theme_name = "Dracula"
      theme_name = "Dracula"
    '';
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = let
        hyprlandConfig = builtins.toFile "hyprland.regreet.conf" ''
          exec-once = regreet; hyprctl dispatch exit;
          windowrulev2=fullscreen, title:^regreet$
          animations {
            enabled = no
          }
          misc {
            disable_hyprland_logo = yes
            disable_splash_rendering = yes
          }
        '';
      in {
        command = "${pkgs.hyprland}/bin/Hyprland --config ${hyprlandConfig}";
      };
    };
  };

  # authentication agent
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
