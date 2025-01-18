{
  lib,
  inputs,
  config,
  ...
}:
{
  imports = [
    inputs.nixcord.homeManagerModules.nixcord
  ];

  options.xfaf.desktop.apps.vencord.enable = lib.mkEnableOption "install 0x5a4s vencord config";

  config = lib.mkIf config.xfaf.desktop.apps.vencord.enable {
    programs.nixcord = {
      enable = true;
      discord.enable = false;
      vesktop.enable = true;

      config =
        let
          enabledPlugins = [
            "accountPanelServerProfile"
            "accountPanelServerProfile"
            "alwaysExpandRoles"
            "anonymiseFileNames"
            "betterGifAltText"
            "betterSessions"
            "betterUploadButton"
            "biggerStreamPreview"
            "blurNSFW"
            "callTimer"
            "clearURLs"
            "copyFileContents"
            "disableCallIdle"
            "fakeNitro"
            "favoriteEmojiFirst"
            "fixCodeblockGap"
            "fixSpotifyEmbeds"
            "forceOwnerCrown"
            "friendsSince"
            "gameActivityToggle"
            "imageLink"
            "imageZoom"
            "loadingQuotes"
            "memberCount"
            "mentionAvatars"
            "messageClickActions"
            "mutualGroupDMs"
            "noF1"
            "noUnblockToJump"
            "onePingPerDM"
            "openInApp"
            "pictureInPicture"
            "previewMessage"
            "roleColorEverywhere"
            "shikiCodeblocks"
            "shikiCodeblocks"
            "sortFriendRequests"
            "typingTweaks"
            "validReply"
            "validUser"
            "voiceChatDoubleClick"
            "whoReacted"
          ];
        in
        {
          plugins =
            lib.recursiveUpdate
              {
                accountPanelServerProfile.prioritizeServerProfile = true;
                shikiCodeblocks.useDevIcon = "COLOR";
              }
              (
                lib.genAttrs enabledPlugins (_: {
                  enable = true;
                })
              );
        };
    };
  };
}
