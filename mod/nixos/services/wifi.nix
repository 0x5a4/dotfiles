{
  lib,
  config,
  ...
}: {
  options.xfaf.services.wifi = {
    enable = lib.mkEnableOption "enable wifi services configuration";

    secretsFile = lib.mkOption {
      type = lib.types.path;
      description = "path to the sops secret file used for passwords";
    };

    hhuEduroam = lib.mkEnableOption "configure hhu eduroam wifi";

    networks = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      description = "map from network ssids to configure to their password environment names";
    };
  };

  config = let
    opts = config.xfaf.services.wifi;
  in
    lib.mkIf opts.enable {
      sops.secrets.wifi = {
        sopsFile = opts.secretsFile;
        format = "binary";
      };

      networking.wireless = {
        enable = true;
        userControlled.enable = true;
        environmentFile = /run/secrets/wifi;

        networks = let
          mkNetwork = ssid: pwdEnv: {
            psk = "@${pwdEnv}@";
          };
        in
          lib.mkMerge [
            (lib.attrsets.mapAttrs mkNetwork opts.networks)
            (lib.mkIf
              opts.hhuEduroam
              {
                eduroam = let
                  cacert = builtins.toFile "ca_cert.pam" ''
                    -----BEGIN CERTIFICATE-----
                    MIIDwzCCAqugAwIBAgIBATANBgkqhkiG9w0BAQsFADCBgjELMAkGA1UEBhMCREUx
                    KzApBgNVBAoMIlQtU3lzdGVtcyBFbnRlcnByaXNlIFNlcnZpY2VzIEdtYkgxHzAd
                    BgNVBAsMFlQtU3lzdGVtcyBUcnVzdCBDZW50ZXIxJTAjBgNVBAMMHFQtVGVsZVNl
                    YyBHbG9iYWxSb290IENsYXNzIDIwHhcNMDgxMDAxMTA0MDE0WhcNMzMxMDAxMjM1
                    OTU5WjCBgjELMAkGA1UEBhMCREUxKzApBgNVBAoMIlQtU3lzdGVtcyBFbnRlcnBy
                    aXNlIFNlcnZpY2VzIEdtYkgxHzAdBgNVBAsMFlQtU3lzdGVtcyBUcnVzdCBDZW50
                    ZXIxJTAjBgNVBAMMHFQtVGVsZVNlYyBHbG9iYWxSb290IENsYXNzIDIwggEiMA0G
                    CSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCqX9obX+hzkeXaXPSi5kfl82hVYAUd
                    AqSzm1nzHoqvNK38DcLZSBnuaY/JIPwhqgcZ7bBcrGXHX+0CfHt8LRvWurmAwhiC
                    FoT6ZrAIxlQjgeTNuUk/9k9uN0goOA/FvudocP05l03Sx5iRUKrERLMjfTlH6VJi
                    1hKTXrcxlkIF+3anHqP1wvzpesVsqXFP6st4vGCvx9702cu+fjOlbpSD8DT6Iavq
                    jnKgP6TeMFvvhk1qlVtDRKgQFRzlAVfFmPHmBiiRqiDFt1MmUUOyCxGVWOHAD3bZ
                    wI18gfNycJ5v/hqO2V81xrJvNHy+SE/iWjnX2J14np+GPgNeGYtEotXHAgMBAAGj
                    QjBAMA8GA1UdEwEB/wQFMAMBAf8wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBS/
                    WSA2AHmgoCJrjNXyYdK4LMuCSjANBgkqhkiG9w0BAQsFAAOCAQEAMQOiYQsfdOhy
                    NsZt+U2e+iKo4YFWz827n+qrkRk4r6p8FU3ztqONpfSO9kSpp+ghla0+AGIWiPAC
                    uvxhI+YzmzB6azZie60EI4RYZeLbK4rnJVM3YlNfvNoBYimipidx5joifsFvHZVw
                    IEoHNN/q/xWA5brXethbdXwFeilHfkCoMRN3zUA7tFFHei4R40cR3p1m0IvVVGb6
                    g1XqfMIpiRvpb7PO4gWEyS8+eIVibslfwXhjdFjASBgMmTnrpMwatXlajRWc2BQN
                    9noHV8cigwUtPJslJj0Ys6lDfMjIq2SPDqO/nBudMNva0Bkuqjzx+zOAduTNrRlP
                    BSeOE6Fuwg==
                    -----END CERTIFICATE-----
                  '';
                in {
                  auth = ''
                    key_mgmt=WPA-EAP
                    pairwise=CCMP
                    eap=TTLS
                    password="@EDUROAM_PASSWORD@"
                    ca_cert="${cacert}"
                    altsubject_match="DNS:radius.hhu.de"
                    phase2="auth=PAP"
                    identity="@EDUROAM_IDENTITY@"
                    anonymous_identity="eduroam@hhu.de"
                    group=CCMP TKIP
                  '';
                };
              })
          ];
      };
    };
}