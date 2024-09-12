{
  config,
  lib,
  ...
}: {
  options.xfaf.services.tlp.enable = lib.mkEnableOption "enable the tlp service";

  config = lib.mkIf config.xfaf.services.tlp.enable {
    services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "powersave";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_AC = "balance_power";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        PLATFORM_PROFILE_ON_AC = "balanced";
        PLATFORM_PROFILE_ON_BAT = "low-power";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 60;
        CPU_BOOST_ON_BAT = 0;
        CPU_HWP_DYN_BOOST_ON_BAT = 0;

        RUNTIME_PM_ON_AC = "on";
        WIFI_PWR_ON_AC = "on";

        START_CHARGE_THRESH_BAT0 = 85;
        STOP_CHARGE_THRESH_BAT0 = 90;

        DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth";

        PCIE_ASPM_ON_BAT = "powersupersave";
      };
    };
  };
}
