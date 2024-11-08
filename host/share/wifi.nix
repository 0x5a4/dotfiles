{ ... }:
{
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
      eduroam = {
        auth = ''
          key_mgmt=WPA-EAP
          pairwise=CCMP
          eap=TTLS
          password=ext:EDUROAM_PASSWORD
          altsubject_match="DNS:radius.hhu.de"
          phase2="auth=PAP"
          identity="bej86nug@hhu.de"
          anonymous_identity="eduroam@hhu.de"
          group=CCMP TKIP
        '';
      };
    };
  };
}
