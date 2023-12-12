{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.firefox = {
    enable = true;

    policies = {
      "DisableFormHistory" = true;
      "DisableFirefoxAccounts" = true;
      "NetworkPrediction" = false;
      "CaptivePortal" = false;
      "DNSOverHTTPS" = {
        "Enabled" = false;
      };
      "DisableFirefoxStudies" = true;
      "DisableTelemetry" = true;
      "DisablePocket" = true;
      "Extensions" = {
        "Uninstall" = [
          "google@search.mozilla.org"
          "bing@search.mozilla.org"
          "amazondotcom@search.mozilla.org"
          "ebay@search.mozilla.org"
          "twitter@search.mozilla.org"
        ];
      };
    };

    profiles.notuser = {
      bookmarks = let
        define = url: {
          name = "";
          url = "https://${url}";
        };
        defineNamed = name: url: {
          name = name;
          url = "https://${url}";
        };
        folder = name: bookmarks: {
          name = name;
          bookmarks = bookmarks;
        };
      in [
        {
          name = "toolbar";
          toolbar = true;
          bookmarks = [
            (define "youtube.com")
            (define "disneyplus.com/en-de")
            (define "ardmediathek.de/tatort")
            (define "wiki.gentoo.org")
            (define "nixos.wiki")
            (define "github.com")
            (define "crates.io")
            (define "feddit.de")
            (folder "tools" [
              (defineNamed "craiyon" "craiyon.com")
              (defineNamed "hex to dec" "www.rapidtables.com/convert/number/hex-to-decimal.html")
              (defineNamed "goodname" "kampersanda.github.io/goodname")
              (defineNamed "plotz" "www.plotz.co.uk")
              (defineNamed "toml validator" "www.toml-lint.com")
              (defineNamed "click" "clickclickclick.click/#4a955f9cf0bbe3854fa9ede6935d540c")
            ])
            (folder "uni" [
              (defineNamed "ilias" "ilias.hhu.de/login.php?client_id=UniRZ&cmd=force_login&lang=de")
              (defineNamed "lsf" "lsf.hhu.de")
              (defineNamed "fscs" "fscs.hhu.de")
              (defineNamed "inphima nextcloud" "nextcloud.inphima.de")
              (defineNamed "mete" "metesecure.hhu-fscs.de")
            ])
            (folder "doc" [
              (defineNamed "lua 5.4 reference" "www.lua.org/manual/5.4")
              (defineNamed "zig langref" "ziglang.org/documentation/master")
              (defineNamed "zig stdref" "ziglang.org/documentation/master/std")
              (defineNamed "hyprland wiki" "wiki.hyprland.org")
              (defineNamed "opencomputers" "ocdoc.cil.li")
              (defineNamed "tomlref" "toml.io/en/v1.0.0")
              (defineNamed "hugo" "gohugo.io/documentation")
              (defineNamed "bootstrap" "getbootstrap.com/docs/")
              (defineNamed "playwright" "playwright.dev/docs/")
            ])
            (folder "work" [
              (defineNamed "moco" "recordbay.mocoapp.com")
            ])
          ];
        }
      ];

      search = {
        default = "DuckDuckGo";
        force = true;
        engines = let
          define = alias: url: iconURL: {
            urls = [{template = "https://${url}";}];
            iconUpdateURL = "https://${iconURL}";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@${alias}"];
          };
        in {
          "Ard Mediathek" = define "ard" "ardmediathek.de/suche/{searchTerms}" "";
          "Youtube" = define "yt" "www.youtube.com/favicon.ico" "";
          "Nix Packages" = define "nixpkg" "search.nixos.org/packages?query={searchTerms}" "nixos.wiki/favicon.png";
          "Nix Options" = define "nixopt" "search.nixos.org/options?query={searchTerms}" "nixos.wiki/favicon.png";
          "Nix Wiki" = define "nixwiki" "nixos.wiki/index.php?search={searchTerms}" "nixos.wiki/favicon.png";
          "Crates.io" = define "crates" "crates.io/search?q={searchTerms}" "crates.io/favicon.ico";
          "Github" = define "gh" "github.com/search?q={searchTerns}&type=repositories" "github.com/favicon.ico";
          "Instant Gaming" = define "ig" "www.instant-gaming.com/en/search/?q={searchTerms}" "www.instant-gaming.com/favicon.ico";
          "ProtonDB" = define "protondb" "www.protondb.com/search?q={searchTerms}" "www.protondb.com/favicon.ico";
          "Modrinth" = define "modrinth" "www.modrinth.com/mods?q={searchTerms}" "www.modrinth.com/favicon.ico";
          "Arch" = define "arch" "wiki.archlinux.org/index.php?search={searchTerms}" "wiki.archlinux.org/favicon.ico";
          "Gentoo" = define "gentoo" "wiki.gentoo.org/index.php?search={searchTerms}" "wiki.gentoo.org/favicon.ico";
          "Portage" = define "portage" "packages.gentoo.org/packages/search?q={searchTerms}" "packages.gentoo.org/favicon.ico";
          "Google".metaData.hidden = true;
          "Bing".metaData.hidden = true;
          "Amazon.de".metaData.hidden = true;
          "eBay".metaData.hidden = true;
          "Twitter".metaData.hidden = true;
        };
      };

      settings = {
        "app.normandy.api_url" = "";
        "app.normandy.enabled" = false;
        "app.shield.optoutstudies.enabled" = false;
        "app.update.auto" = false;
        "beacon.enabled" = false;
        "breakpad.reportURL" = "";
        "browser.aboutConfig.showWarning" = false;
        "browser.cache.offline.enable" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
        "browser.crashReports.unsubmittedCheck.enabled" = false;
        "browser.disableResetPrompt" = true;
        "browser.fixup.alternate.enabled" = false;
        "browser.newtab.preload" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.enhanced" = false;
        "browser.newtabpage.introShown" = true;
        "browser.safebrowsing.appRepURL" = "";
        "browser.safebrowsing.blockedURIs.enabled" = false;
        "browser.safebrowsing.downloads.enabled" = false;
        "browser.safebrowsing.downloads.remote.enabled" = false;
        "browser.safebrowsing.downloads.remote.url" = "";
        "browser.safebrowsing.enabled" = false;
        "browser.safebrowsing.malware.enabled" = false;
        "browser.safebrowsing.phishing.enabled" = false;
        "browser.selfsupport.url" = "";
        "browser.send_pings" = false;
        "browser.sessionstore.privacy_level" = 0;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.urlbar.groupLabels.enabled" = false;
        "browser.urlbar.quicksuggest.enabled" = false;
        "browser.urlbar.speculativeConnect.enabled" = false;
        "browser.urlbar.trimURLs" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "device.sensors.ambientLight.enabled" = false;
        "device.sensors.enabled" = false;
        "device.sensors.motion.enabled" = false;
        "device.sensors.orientation.enabled" = false;
        "device.sensors.proximity.enabled" = false;
        "dom.battery.enabled" = false;
        "dom.event.clipboardevents.enabled" = false;
        "dom.security.https_only_mode" = true;
        "dom.security.https_only_mode_ever_enabled" = true;
        "dom.webaudio.enabled" = false;
        "experiments.activeExperiment" = false;
        "experiments.enabled" = false;
        "experiments.manifest.uri" = "";
        "experiments.supported" = false;
        "extensions.getAddons.cache.enabled" = false;
        "extensions.getAddons.showPane" = false;
        "extensions.pocket.enabled" = false;
        "extensions.shield-recipe-client.api_url" = "";
        "extensions.shield-recipe-client.enabled" = false;
        "extensions.webservice.discoverURL" = "";
        "media.autoplay.default" = 1;
        "media.autoplay.enabled" = false;
        "media.eme.enabled" = false;
        "media.gmp-widevinecdm.enabled" = false;
        "media.navigator.enabled" = false;
        "media.peerconnection.enabled" = false;
        "media.video_stats.enabled" = false;
        "network.allow-experiments" = false;
        "network.captive-portal-service.enabled" = false;
        "network.cookie.cookieBehavior" = 1;
        "network.dns.disablePrefetch" = true;
        "network.dns.disablePrefetchFromHTTPS" = true;
        "network.http.referer.spoofSource" = true;
        "network.http.speculative-parallel-limit" = 0;
        "network.predictor.enable-prefetch" = false;
        "network.predictor.enabled" = false;
        "network.prefetch-next" = false;
        "network.trr.mode" = 5;
        "privacy.donottrackheader.enabled" = true;
        "privacy.donottrackheader.value" = 1;
        "privacy.query_stripping" = true;
        "privacy.resistFingerprinting" = true;
        "privacy.trackingprotection.cryptomining.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.pbmode.enabled" = true;
        "privacy.usercontext.about_newtab_segregation.enabled" = true;
        "security.ssl.disable_session_identifiers" = true;
        "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSite" = false;
        "signon.autofillForms" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.cachedClientID" = "";
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.prompted" = 2;
        "toolkit.telemetry.rejected" = true;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.unifiedIsOptIn" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "webgl.disabled" = true;
        "webgl.renderer-string-override" = " ";
        "webgl.vendor-string-override" = " ";
        "browser.bookmarks.addedImportButton" = true;
        "browser.places.importBookmarksHTML" = false;
        "browser.newtabpage.activity-stream.section.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsored" = false;
        "privacy.sanitize.sanitizeOnShutdown" = true;
        "privacy.sanitize.pending" = [
          {
            "id" = "shutdown";
            "itemsToClear" = [
              "cache"
              "cookies"
              "offlineApps"
              "history"
              "formdata"
              "downloads"
            ];
            "options" = {};
          }
        ];
      };

      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        bitwarden
        ublock-origin
        darkreader
        decentraleyes
        i-dont-care-about-cookies
        privacy-possum
        clearurls
        return-youtube-dislikes
        boring-rss
        don-t-fuck-with-paste
        enhanced-github
        enhanced-h264ify
        github-file-icons
        multi-account-containers
      ];
    };
  };
}
