{ config, ... }:
{
  sops.secrets.easyroam = {
    sopsFile = ../secrets/easyroam; 
    format = "binary";
  };
  
  services.easyroam = {
    enable = true;
    pkcsFile = config.sops.secrets.easyroam.path;
    network = {
      configure = true;
      commonName = "3252125432889295763@easyroam-pca.uni-duesseldorf.de";
    };
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
    };
  };
}
