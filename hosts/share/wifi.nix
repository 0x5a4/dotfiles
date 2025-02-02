{ config, ... }:
{
  sops.secrets.easyroam = {
    sopsFile = ../secrets/easyroam;
    format = "binary";
    restartUnits = [ "easyroam-install.service" ];
  };

  services.easyroam = {
    enable = true;
    pkcsFile = config.sops.secrets.easyroam.path;
    wpa-supplicant.enable = true;
  };

  xfaf.services.wifi = {
    enable = true;
    secretsFile = ../secrets/wifi;
    networks = {
      HHUD-Y = "HHUDY";
      UdoLandenberg = "UDOLANDENBERG";
      "chaosdorf access" = "CHAOSDORFACCESS";
      Vodafone-6F04 = "VODAFONE6F04";
      WLAN-135020 = "WLAN135020";
      SportfreundeCore = "SPORTFREUNDECORE";
      Fritzbold = "FRITZBOLD";
      "oh uff hallo gustavsob" = "GUSTAVSOB";
      LambdaAufDemEFeld = "PHYSIKWLAN";
      "Network_Mr.X" = "NETWORKMRX";
      FelixPhone = "FELIXPHONE";
      "bUm gast" = "BUMGAST";
      WIFIonICE = { };
      TENTEN = "TENTEN";
    };
  };
}
