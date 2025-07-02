# Vesktop configuration for NixOS Home Manager
{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.vesktop = {
    enable = true;

    vencord = {
      enable = true;

      settings = lib.mkForce {
        # Core settings
        autoUpdate = false;
        autoUpdateNotification = true;
        useQuickCss = true;
        themeLinks = [];
        enabledThemes = [
          "pywal-discord-default.theme.css"
        ];
        enableReactDevtools = false;
        frameless = false;
        transparent = true;
        winCtrlQ = false;
        disableMinSize = false;
        winNativeTitleBar = false;

        # Notification settings
        notifications = {
          timeout = 5000;
          position = "bottom-right";
          useNative = "not-focused";
          logLimit = 50;
        };

        # Cloud settings
        cloud = {
          authenticated = false;
          url = "https://api.vencord.dev/";
          settingsSync = false;
          settingsSyncVersion = 1743007823644;
        };

        notifyAboutUpdates = true;
        macosTranslucency = false;
        eagerPatches = false;

        # Plugin configurations
        plugins = {
          # API plugins
          BadgeAPI.enabled = true;
          CommandsAPI.enabled = true;
          ContextMenuAPI.enabled = true;
          MemberListDecoratorsAPI.enabled = true;
          MessageAccessoriesAPI.enabled = true;
          MessageDecorationsAPI.enabled = true;
          MessageEventsAPI.enabled = true;
          MessagePopoverAPI.enabled = true;
          NoticesAPI.enabled = true;
          ServerListAPI.enabled = true;
          SettingsStoreAPI.enabled = false;
          ChatInputButtonAPI.enabled = true;
          MessageUpdaterAPI.enabled = false;
          UserSettingsAPI.enabled = true;
          DynamicImageModalAPI.enabled = true;

          # Core plugins
          NoTrack = {
            enabled = true;
            disableAnalytics = true;
          };

          Settings = {
            enabled = true;
            settingsLocation = "aboveActivity";
          };

          # UI Enhancement plugins
          BetterUploadButton.enabled = true;
          BiggerStreamPreview.enabled = true;
          CallTimer = {
            enabled = true;
            format = "stopwatch";
          };
          ClearURLs.enabled = true;
          CrashHandler.enabled = true;
          EmoteCloner.enabled = true;

          FakeNitro = {
            enabled = true;
            enableEmojiBypass = true;
            enableStickerBypass = true;
            enableStreamQualityBypass = true;
            transformStickers = true;
            transformEmojis = true;
            transformCompoundSentence = true;
            stickerSize = 160;
            emojiSize = 48;
            useHyperLinks = true;
            hyperLinkText = "{{NAME}}";
            disableEmbedPermissionCheck = false;
          };

          FakeProfileThemes = {
            enabled = true;
            nitroFirst = true;
          };

          FavoriteEmojiFirst.enabled = true;
          ForceOwnerCrown.enabled = true;

          ImageZoom = {
            enabled = true;
            size = 629.5486733094355;
            zoom = 6.351393481420199;
            nearestNeighbour = false;
            square = false;
            saveZoomValues = true;
            zoomSpeed = 2.459991640610526;
            preventCarouselFromClosingOnClick = true;
            invertScroll = true;
          };

          MemberCount = {
            enabled = true;
            memberList = true;
            toolTip = true;
          };

          MessageClickActions = {
            enabled = true;
            enableDeleteOnClick = false;
            enableDoubleClickToEdit = true;
            enableDoubleClickToReply = true;
            requireModifier = false;
          };

          MoreUserTags = {
            enabled = true;
            tagSettings = {
              WEBHOOK = {
                text = "Webhook";
                showInChat = true;
                showInNotChat = true;
              };
              OWNER = {
                text = "Owner";
                showInChat = true;
                showInNotChat = true;
              };
              ADMINISTRATOR = {
                text = "Admin";
                showInChat = true;
                showInNotChat = true;
              };
              MODERATOR_STAFF = {
                text = "Staff";
                showInChat = true;
                showInNotChat = true;
              };
              MODERATOR = {
                text = "Mod";
                showInChat = true;
                showInNotChat = true;
              };
              VOICE_MODERATOR = {
                text = "VC Mod";
                showInChat = true;
                showInNotChat = true;
              };
              CHAT_MODERATOR = {
                text = "Chat Mod";
                showInChat = true;
                showInNotChat = true;
              };
            };
          };

          # Privacy & Security
          NoScreensharePreview.enabled = true;
          NoSystemBadge.enabled = true;
          NoUnblockToJump.enabled = true;
          NSFWGateBypass.enabled = true;
          NoTypingAnimation.enabled = true;

          # App Integration
          OpenInApp = {
            enabled = true;
            spotify = true;
            steam = true;
            epic = true;
            tidal = true;
            itunes = true;
          };

          # Permissions
          PermissionsViewer = {
            enabled = true;
            permissionsSortOrder = 0;
            defaultPermissionsDropdownState = false;
          };

          # Fun plugins
          petpet.enabled = true;
          UwUifier = {
            enabled = true;
            uwuEveryMessage = false;
          };

          # Platform features
          PlatformIndicators = {
            enabled = true;
            colorMobileIndicator = true;
            list = true;
            badges = true;
            messages = true;
          };

          # Quick actions
          QuickMention.enabled = true;
          QuickReply = {
            enabled = true;
            shouldMention = 2;
          };

          ReadAllNotificationsButton.enabled = true;

          RelationshipNotifier = {
            enabled = true;
            offlineRemovals = true;
            groups = true;
            servers = true;
            friends = true;
            friendRequestCancels = true;
          };

          RoleColorEverywhere = {
            enabled = true;
            chatMentions = true;
            memberList = true;
            voiceUsers = true;
            reactorsList = true;
            colorChatMessages = false;
            pollResults = true;
          };

          ShowAllMessageButtons.enabled = true;
          ShowMeYourName = {
            enabled = true;
            mode = "nick-user";
            displayNames = false;
            inReplies = true;
          };

          SilentTyping = {
            enabled = true;
            showIcon = true;
            isEnabled = true;
          };

          SortFriendRequests = {
            enabled = true;
            showDates = false;
          };

          SpotifyCrack = {
            enabled = true;
            noSpotifyAutoPause = true;
            keepSpotifyActivityOnIdle = false;
          };

          SupportHelper.enabled = true;

          UserVoiceShow = {
            enabled = true;
            showInUserProfileModal = true;
            showVoiceChannelSectionHeader = true;
            showInMemberList = true;
            showInMessages = true;
          };

          ValidUser.enabled = true;
          VoiceChatDoubleClick.enabled = true;

          ViewIcons = {
            enabled = true;
            format = "webp";
            imgSize = "1024";
          };

          VolumeBooster = {
            enabled = true;
            multiplier = 2;
          };

          # Additional plugins
          GreetStickerPicker.enabled = true;
          VoiceMessages.enabled = true;
          SecretRingToneEnabler = {
            enabled = true;
            onlySnow = false;
          };

          NormalizeMessageLinks.enabled = true;
          FixSpotifyEmbeds = {
            enabled = true;
            volume = 10;
          };

          WebContextMenus = {
            enabled = true;
            addBack = true;
          };

          WebKeybinds.enabled = true;
          BetterGifPicker.enabled = true;
          FixCodeblockGap.enabled = true;
          FixYoutubeEmbeds.enabled = true;
          DisableCallIdle.enabled = true;

          NewGuildSettings = {
            enabled = true;
            guild = true;
            everyone = false;
            role = false;
            showAllChannels = true;
          };

          FriendsSince.enabled = true;
          BetterSettings = {
            enabled = true;
            disableFade = true;
            organizeMenu = true;
            eagerLoad = true;
          };

          UnlockedAvatarZoom = {
            enabled = true;
            zoomMultiplier = 4;
          };

          WebScreenShareFixes.enabled = true;
          ServerInfo.enabled = true;
          NoOnboardingDelay.enabled = true;

          # iLoveSpam (anti-spam)
          iLoveSpam.enabled = true;

          # CustomRPC (disabled but configured)
          CustomRPC = {
            enabled = false;
            type = 5;
            appID = "1007006846655143966";
            appName = ".";
            details = "УВАГА!!!!!!!!!!!";
            state = "кто будет плохо сосать, ";
            imageBig = "https://cdn.discordapp.com/attachments/1040677763629203577/1171049655476441118/1136337709875593226.gif?ex=655b43fa&is=6548cefa&hm=c06a631f2788b9bbdf284ab4372bf87ca539f6ba3d21d413455fa72b81911e29&";
            imageBigTooltip = "будет пересасывать))";
            timestampMode = 0;
            imageSmall = "https://cdn.discordapp.com/attachments/1040677763629203577/1171049655476441118/1136337709875593226.gif?ex=655b43fa&is=6548cefa&hm=c06a631f2788b9bbdf284ab4372bf87ca539f6ba3d21d413455fa72b81911e29&";
            imageSmallTooltip = "ОБЯЗАН ПЕРЕСАСЫВАТЬ";
          };

          # Disabled plugins
          AlwaysAnimate.enabled = false;
          AlwaysTrust.enabled = false;
          AnonymiseFileNames.enabled = false;
          BANger = {
            enabled = false;
            source = "https://i.imgur.com/wp5q52C.mp4";
          };
          BetterFolders = {
            enabled = false;
            sidebar = true;
            sidebarAnim = true;
            closeAllFolders = false;
            closeAllHomeButton = false;
            closeOthers = false;
            forceOpen = false;
          };
          BetterGifAltText.enabled = false;
          BetterNotesBox = {
            enabled = false;
            hide = false;
            noSpellCheck = true;
          };
          BetterRoleDot = {
            enabled = false;
            bothStyles = false;
            copyRoleColorInProfilePopout = false;
          };
          BlurNSFW = {
            enabled = false;
            blurAmount = 0;
          };
          ColorSighted.enabled = false;
          ConsoleShortcuts.enabled = false;
          Experiments = {
            enabled = false;
            enableIsStaff = false;
            forceStagingBanner = false;
          };
          F8Break.enabled = false;
          FixInbox.enabled = false;
          FriendInvites.enabled = false;
          GameActivityToggle.enabled = false;
          GifPaste.enabled = false;
          IgnoreActivities.enabled = false;
          InvisibleChat = {
            enabled = false;
            savedPasswords = "password, Password";
          };
          KeepCurrentChannel.enabled = false;
          LastFMRichPresence.enabled = false;
          LoadingQuotes.enabled = false;
          MessageLinkEmbeds = {
            enabled = false;
            automodEmbeds = "never";
            listMode = "blacklist";
            idList = "";
          };
          MessageLogger = {
            enabled = false;
            deleteStyle = "text";
            ignoreBots = false;
            ignoreSelf = true;
            ignoreUsers = "";
            ignoreChannels = "";
            ignoreGuilds = "449175561529589761, ";
          };
          MessageTags.enabled = false;
          MoreCommands.enabled = false;
          MoreKaomoji.enabled = false;
          Moyai = {
            enabled = false;
            volume = 0.5;
            quality = "Normal";
            triggerWhenUnfocused = true;
            ignoreBots = true;
            ignoreBlocked = true;
          };
          MutualGroupDMs.enabled = false;
          NoBlockedMessages.enabled = false;
          NoDevtoolsWarning.enabled = false;
          NoF1.enabled = false;
          NoPendingCount.enabled = false;
          NoProfileThemes.enabled = false;
          NoRPC.enabled = false;
          NoReplyMention = {
            enabled = false;
            userList = "1234567890123445,1234567890123445";
            shouldPingListed = true;
          };
          oneko.enabled = false;
          PinDMs.enabled = false;
          PlainFolderIcon.enabled = false;
          ReactErrorDecoder.enabled = false;
          RevealAllSpoilers.enabled = false;
          ReverseImageSearch.enabled = false;
          ReviewDB.enabled = false;
          SendTimestamps = {
            enabled = false;
            replaceMessageContents = true;
          };
          ServerListIndicators.enabled = false;
          ShikiCodeblocks.enabled = false;
          ShowConnections.enabled = false;
          ShowHiddenChannels = {
            enabled = false;
            hideUnreads = true;
            showMode = 1;
            defaultAllowedUsersAndRolesDropdownState = true;
          };
          SilentMessageToggle = {
            enabled = false;
            persistState = false;
            autoDisable = true;
          };
          SpotifyControls.enabled = false;
          SpotifyShareCommands.enabled = false;
          StartupTimings.enabled = false;
          TextReplace.enabled = false;
          TimeBarAllActivities.enabled = false;
          Translate.enabled = false;
          TypingIndicator.enabled = false;
          TypingTweaks = {
            enabled = false;
            showAvatars = true;
            showRoleColors = true;
            alternativeFormatting = true;
          };
          Unindent.enabled = false;
          UnsuppressEmbeds.enabled = false;
          UrbanDictionary.enabled = false;
          USRBG = {
            enabled = false;
            nitroFirst = true;
            voiceBackground = true;
          };
          VcNarrator.enabled = false;
          VencordToolbox.enabled = false;
          ViewRaw.enabled = false;
          WhoReacted.enabled = false;
          Wikisearch.enabled = false;
          FavoriteGifSearch.enabled = true;
          PreviewMessage.enabled = false;
          CopyUserURLs.enabled = false;
          PictureInPicture.enabled = false;
          ThemeAttributes.enabled = false;
          Dearrow.enabled = false;
          OnePingPerDM.enabled = false;
          PermissionFreeWill = {
            enabled = false;
            lockout = true;
            onboarding = true;
          };
          NoMosaic.enabled = false;
          "WebRichPresence (arRPC)".enabled = false;
          SuperReactionTweaks.enabled = false;
          ClientTheme = {
            enabled = false;
            color = "1e2327";
          };
          Decor.enabled = false;
          NotificationVolume.enabled = false;
          XSOverlay.enabled = false;
          BetterRoleContext.enabled = false;
          ResurrectHome.enabled = false;
          OverrideForumDefaults.enabled = false;
          PartyMode = {
            enabled = false;
            superIntensePartyMode = 0;
          };
          ShowHiddenThings = {
            enabled = false;
            showTimeouts = true;
            showInvitesPaused = true;
            showModView = true;
            disableDiscoveryFilters = true;
            disableDisallowedDiscoveryFilters = true;
          };
          AutomodContext.enabled = false;
          BetterSessions.enabled = false;
          CtrlEnterSend.enabled = false;
          CustomIdle.enabled = false;
          ImageLink.enabled = false;
          ImplicitRelationships.enabled = false;
          MessageLatency.enabled = false;
          NoDefaultHangStatus.enabled = false;
          NoServerEmojis.enabled = false;
          PauseInvitesForever.enabled = false;
          ReplaceGoogleSearch.enabled = false;
          ReplyTimestamp.enabled = false;
          ShowTimeoutDuration.enabled = false;
          StreamerModeOnStream.enabled = false;
          ValidReply.enabled = false;
          VoiceDownload.enabled = false;
          DontRoundMyTimestamps.enabled = false;
          MaskedLinkPaste.enabled = false;
          Summaries.enabled = false;
          AppleMusicRichPresence.enabled = false;
          CopyEmojiMarkdown.enabled = false;
          ConsoleJanitor.enabled = false;
          YoutubeAdblock.enabled = false;
          MentionAvatars.enabled = false;
          AlwaysExpandRoles.enabled = false;
          FullSearchContext.enabled = false;
          UserMessagesPronouns.enabled = false;
          AccountPanelServerProfile.enabled = false;
          CopyFileContents.enabled = false;
          FixImagesQuality.enabled = false;
          NoMaskedUrlPaste.enabled = false;
          StickerPaste.enabled = false;
          HideMedia.enabled = false;
          FullUserInChatbox.enabled = false;
          IrcColors.enabled = false;
        };
      };

      # QuickCSS with Gruvbox theme
      quickCss = ''
        * {\n\t--gruv-dark-bg-hard: 29, 32, 33;\n\t--gruv-dark-bg: 40 40 40;\n\t--gruv-dark-bg-alt: 33, 33, 33;\n\t--gruv-dark-bg-soft: 50, 48, 47;\n\t--gruv-dark-bg1: 60, 56, 54;\n\t--gruv-dark-bg2: 80, 73, 69;\n\t--gruv-dark-bg3: 102, 92, 84;\n\t--gruv-dark-bg4: 124, 111, 100;\n\n\t--gruv-dark-fg-hard: 251, 241, 199;\n\t--gruv-dark-fg: 235, 219, 178;\n\t--gruv-dark-fg1: 213, 196, 161;\n\t--gruv-dark-fg2: 189, 174, 147;\n\t--gruv-dark-fg3: 168, 153, 132;\n\n\t--gruv-dark-purple-dark: 177, 98, 134;\n\t--gruv-dark-purple-light: 211, 134, 155;\n\n\t--gruv-dark-yellow-dark: 215, 153, 33;\n\t--gruv-dark-yellow-light: 250, 189, 47;\n\t\n\t--gruv-dark-red-dark: 204, 36, 29;\n\t--gruv-dark-red-light: 251, 73, 52;\n\n\t--gruv-dark-orange-dark: 214, 93, 14;\n\t--gruv-dark-orange-light: 254, 128, 25;\n\n\t--gruv-dark-blue-dark: 69, 133, 136;\n\t--gruv-dark-blue-light: 131, 165, 152;\n\n\t--gruv-dark-green-dark: 152, 151, 26;\n\t--gruv-dark-green-light: 184, 187, 38;\n\n\t--gruv-dark-aqua-dark: 104, 157, 106;\n\t--gruv-dark-aqua-light: 142, 192, 124;\n\n\t--gruv-dark-gray-dark: 146, 131, 116;\n\t--gruv-dark-gray-light: 168, 153, 132;\n\n\t/* ============================================================== */\n\n\t--gruv-dark-text-hard:           var(--gruv-dark-fg-hard);\n\t--gruv-dark-text-primary:        var(--gruv-dark-fg);\n\t--gruv-dark-text-secondary:      var(--gruv-dark-fg1);\n\t--gruv-dark-text-tertiary:       var(--gruv-dark-fg2);\n\t--gruv-dark-text-muted:          var(--gruv-dark-fg3);\n\t--gruv-dark-text-danger:         var(--gruv-dark-red-light);\n\t--gruv-dark-text-inverted-hard:  var(--gruv-dark-text-hard);\n\t--gruv-dark-text-inverted:       var(--gruv-dark-bg);\n\n\t--gruv-dark-background-positive: var(--gruv-dark-green-dark);\n\n\t--gruv-dark-accent: var(--gruv-dark-yellow-light);\n\t--gruv-dark-accent-hover: var(--gruv-dark-accent);\n\n\t--gruv-dark-icon-color: var(--gruv-dark-fg2);\n\t--gruv-dark-icon-color-hover: var(--gruv-dark-fg);\n\t--gruv-dark-icon-color-hover-harder: var(--gruv-dark-fg-hard);\n\t--gruv-dark-icon-color-muted: var(--gruv-dark-fg3);\n\n\t--gruv-dark-link-color: var(--gruv-dark-blue-light);\n\n\t--gruv-dark-border-default: var(--gruv-dark-bg3);\n\t--gruv-dark-border-hover: var(--gruv-dark-bg2);\n\n\t--gruv-dark-button-color-default: var(--gruv-dark-yellow-dark);\n\t--gruv-dark-button-color-hover:   rgba(var(--gruv-dark-button-color-default), 0.7);\n\t--gruv-dark-button-text-default: var(--gruv-dark-bg);\n\t--gruv-dark-button-text-dark: var(--gruv-dark-text-primary);\n\t--gruv-dark-button-text-dark-muted: var(--gruv-dark-text-muted);\n\n\t--gruv-dark-button-alt-default: var(--gruv-dark-bg-soft);\n\t--gruv-dark-button-alt-hover:   var(--gruv-dark-bg);\n\n\t--gruv-dark-button-positive-default: var(--gruv-dark-green-dark);\n\t--gruv-dark-button-positive-hover:   rgba(var(--gruv-dark-green-dark), 0.8);\n\t\n\t--gruv-dark-input-box-background: var(--gruv-dark-bg-soft);\n\n\t--gruv-dark-scrollbar-color: var(--gruv-dark-bg3);\n\t--gruv-dark-scrollbar-background: transparent;\n\n\t--gruv-dark-selected-tab: var(--gruv-dark-bg1);\n\n\t--gruv-dark-status-online: var(--gruv-dark-green-dark);\n\t--gruv-dark-status-offline: var(--gruv-dark-text-muted);\n\t--gruv-dark-status-idle: rgba(var(--gruv-dark-accent), 0.8);\n\t--gruv-dark-status-dnd: var(--gruv-dark-red-dark);\n}\n\n/* .visual-refresh.theme-dark, */\n/* .visual-refresh .theme-dark, */\n/* [class*=vc-membercount-total], */\n/* .visual-refresh, */\n/* .theme-dark { */\n* {\n\t--__header-bar-background: rgba(var(--gruv-dark-bg-hard));\n\t--autocomplete-bg: rgba(var(--gruv-dark-bg));\n\n\t--background-primary:  rgba(var(--gruv-dark-bg));      /* #282828 */\n\t--background-secondary: rgba(var(--gruv-dark-bg-alt)) ; /* #212121 */\n\t--background-secondary-alt: rgba(var(--gruv-dark-bg-soft));\n\t--background-tertiary: rgba(var(--gruv-dark-bg-soft)); /* #32302f */\n\n\t--background-base-lower: rgba(var(--gruv-dark-bg));\n\t--background-base-low: rgba(var(--gruv-dark-bg));\n\t--background-base-lowest: rgba(var(--gruv-dark-bg-hard));\n\t--background-floating: rgba(var(--gruv-dark-bg-hard)); /* #1d2021 */\n\n\t--background-surface-high: rgba(var(--gruv-dark-bg-soft));\n\t--background-surface-higher: rgba(var(--gruv-dark-bg));\n\t--background-surface-highest: rgba(var(--gruv-dark-bg));\n\n\t--background-feedback-critical: rgba(var(--gruv-dark-red-dark), 0.08);\n\t--background-feedback-positive: rgba(var(--gruv-dark-green-dark), 0.08);\n\n\t--background-modifier-accent: rgba(var(--gruv-dark-border-hover));\n\t--background-modifier-selected: rgba(var(--gruv-dark-selected-tab));\n\n\t--background-mentioned: rgba(var(--gruv-dark-accent), 0.1);\n\t--background-mentioned-hover: rgba(var(--gruv-dark-accent), 0.15);\n\n\t--background-message-automod: rgba(var(--gruv-dark-accent), 0.1);\n\t--background-message-automod-hover: rgba(var(--gruv-dark-accent), 0.15);\n\n\t--background-accent: rgba(var(--gruv-dark-bg1));\n\n\t--bg-base-primary: rgba(var(--gruv-dark-bg));\n\t--bg-base-secondary: rgba(var(--gruv-dark-bg)); \n\t--bg-base-tertiary: rgba(var(--gruv-dark-bg-hard));\n\t\n\t--bg-surface-overlay: rgba(var(--gruv-dark-bg));\n\n\t/* Please check this afterwards */\n\t--card-primary-bg:  rgba(var(--gruv-dark-bg-hard));\n\n\t--bg-brand: rgba(var(--gruv-dark-accent), 0.8);\n\n\t--bg-mod-faint: rgba(var(--gruv-dark-bg-soft));\n\t--bg-mod-strong: rgba(var(--gruv-dark-bg2));\n\t--bg-mod-subtle: rgba(var(--gruv-dark-bg1));\n\n\t--border-normal: rgba(var(--gruv-dark-border-hover));\n\t--border-strong: rgba(var(--gruv-dark-border-default));\n\t--border-faint:  rgba(var(--gruv-dark-border-hover));\n\t--border-subtle: rgba(var(--gruv-dark-border-hover));\n\n\t--background-message-hover: rgba(var(--gruv-dark-bg1));\n\n\t--text-primary: rgba(var(--gruv-dark-fg-hard)); /* #fbf1c7  */\n\t--text-normal:  rgba(var(--gruv-dark-fg));      /* #ebdbb2  */\n\t--text-default: rgba(var(--gruv-dark-fg));      /* #ebdbb2  */\n\t--text-secondary: rgba(var(--gruv-dark-fg1));   /* #d5c4a1 */\n\t--text-tertiary: rgba(var(--gruv-dark-fg2));    /* #bdae93 */\n\t--text-positive: rgba(var(--gruv-dark-green-dark));\n\n\t--text-link: rgba(var(--gruv-dark-link-color));\n\t--text-muted: rgba(var(--gruv-dark-text-muted));\n\t--text-brand: rgba(var(--gruv-dark-accent));\n\t--text-muted-on-default: rgba(var(--gruv-dark-text-muted));\n\n\t--text-feedback-positive: rgba(var(--gruv-dark-green-dark));\n\n\t--text-code-comment: rgba(var(--gruv-dark-gray-light));\n\t--text-code-default: rgba(var(--gruv-dark-blue-light));\n\t--text-code-keyword: rgba(var(--gruv-dark-purple-light));\n\t--text-code-variable: rgba(var(--gruv-dark-blue-light));\n\t--text-code-builtin: rgba(var(--gruv-dark-purple-light));\n\t--text-code-string: rgba(var(--gruv-dark-aqua-light));\n\n\t--header-primary: rgba(var(--gruv-dark-text-primary));\n\t--header-secondary: rgba(var(--gruv-dark-text-tertiary));\n\t--header-muted: rgba(var(--gruv-dark-text-muted));\n\n\t--checkbox-border-default: rgba(var(--gruv-dark-border-default));\n\t--checkbox-border-checked: rgba(var(--gruv-dark-border-default));\n\t--checkbox-background-default: rgba(var(--gruv-dark-bg-soft));\n\t--checkbox-background-checked: rgba(var(--gruv-dark-background-positive));\n\n\t--channel-icon: rgba(var(--gruv-dark-icon-color));\n\t--channels-default: rgba(var(--gruv-dark-fg3));\n\n\t--custom-notice-background: rgba(var(--gruv-dark-green-dark));\n\t--custom-notice-text: rgba(var(--gruv-dark-text-hard));\n\n\t--notice-background-positive: rgba(var(--gruv-dark-green-dark));\n\t--notice-background-warning: rgba(var(--gruv-dark-yellow-dark), 0.8);\n\t--notice-background-critical: rgba(var(--gruv-dark-red-dark));\n\n\t--notice-text-positive: rgba(var(--gruv-dark-text-inverted-hard));\n\n\t--link-color: rgba(var(--gruv-dark-blue-dark));\n\n\t--icon-primary:   rgba(var(--gruv-dark-icon-color));\n\t--icon-secondary: rgba(var(--gruv-dark-icon-color));\n\t--icon-tertiary:  rgba(var(--gruv-dark-icon-color));\n\t--icon-default:   rgba(var(--gruv-dark-icon-color));\n\t--icon-muted:     rgba(var(--gruv-dark-icon-color-muted));\n\n\t--input-background: rgba(var(--gruv-dark-input-box-background));\n\t--input-border: rgba(var(--gruv-dark-border-default));\n\t--input-placeholder-text: rgba(var(--gruv-dark-text-tertiary));\n\n\t--modal-background: rgba(var(--gruv-dark-bg-hard));\n\t--modal-footer-background: rgba(var(--gruv-dark-bg));\n\n\t--mention-foreground: rgba(var(--gruv-dark-fg-hard));\n\t--mention-background: rgba(var(--gruv-dark-bg2));\n\n\t--scrollbar-auto-thumb: rgba(var(--gruv-dark-scrollbar-color));\n\t--scrollbar-auto-track: rgba(var(--gruv-dark-scrollbar-background));\n\t--scrollbar-thin-thumb: rgba(var(--gruv-dark-scrollbar-color));\n\t--scrollbar-auto-scrollbar-color-thumb: rgba(var(--gruv-dark-scrollbar-color));\n\t--scrollbar-auto-scrollbar-color-track: rgba(var(--gruv-dark-scrollbar-color));\n\n\t--button-filled-brand-text: rgba(var(--gruv-dark-button-text-default));\n\t--button-filled-brand-border: rgba(var(--gruv-dark-button-color-default));\n\t--button-filled-brand-background: rgba(var(--gruv-dark-button-color-default));\n\t--button-filled-brand-background-active: rgba(var(--gruv-dark-button-color-default));\n    --button-filled-brand-background-hover: var(--gruv-dark-button-color-hover);\n\n\t--button-danger-background:          rgba(var(--gruv-dark-red-dark));\n\t--button-danger-background-active:   rgba(var(--gruv-dark-red-light));\n\t--button-danger-background-disabled: rgba(var(--gruv-dark-red-dark), 0.8);\n\t--button-danger-background-hover:    rgba(var(--gruv-dark-red-dark), 0.7);\n\t--button-danger-border: rgba(var(--gruv-dark-red-dark));\n\n\t--button-outline-danger-background: rgba(var(--gruv-dark-button-alt-default));\n\t--button-outline-danger-background-hover: rgba(var(--gruv-dark-button-alt-hover));\n\t--button-outline-danger-border: rgba(var(--gruv-dark-border-default));\n\t--button-outline-danger-border-hover: rgba(var(--gruv-dark-border-hover));\n\t--button-outline-danger-text: rgba(var(--gruv-dark-button-text-dark-muted));\n\t--button-outline-danger-text-hover: rgba(var(--gruv-dark-text-danger));\n\n\t--button-positive-background: rgba(var(--gruv-dark-button-positive-default));\n\t--button-positive-background-hover: var(--gruv-dark-button-positive-hover);\n\t--button-positive-border: rgba(var(--gruv-dark-button-positive-default));\n\n\t--button-secondary-background: rgba(var(--gruv-dark-bg-soft));\n\t--button-secondary-background-hover: rgba(var(--gruv-dark-bg));\n\t--button-secondary-text: rgba(var(--gruv-dark-button-text-dark-muted));\n\n\t--button-transparent-background: rgba(var(--gruv-dark-button-alt-default));\n\t--button-transparent-background-hover: rgba(var(--gruv-dark-button-alt-hover));\n\t--button-transparent-text: rgba(var(--gruv-dark-button-text-dark));\n\n\t--primary-630: rgba(var(--gruv-dark-button-alt-default));\n\t--primary-700: rgba(var(--gruv-dark-button-alt-hover));\n\n\t--background-code: rgba(var(--gruv-dark-bg-hard));\n\n\t--status-online: rgba(var(--gruv-dark-status-online));\n\t--status-offline: rgba(var(--gruv-dark-status-offline));\n\t--status-idle: var(--gruv-dark-status-idle);\n\t--status-dnd: rgba(var(--gruv-dark-status-dnd));\n\n\t--status-positive: rgba(var(--gruv-dark-green-dark));\n\t--status-positive-background: rgba(var(--gruv-dark-green-dark));\n\t--status-positive-text: rgba(var(--gruv-dark-text-inverted-hard));\n\n\t--status-danger: rgba(var(--gruv-dark-red-dark));\n\t--status-danger-background: rgba(var(--gruv-dark-red-dark));\n\t--status-danger-text: rgba(var(--gruv-dark-text-primary));\n\n\t--status-warning: rgba(var(--gruv-dark-orange-dark));\n\t--status-warning-background: rgba(var(--gruv-dark-orange-dark));\n\t--status-warning-text: rgba(var(--gruv-dark-text-inverted-hard));\n\n\t--status-speaking: rgba(var(--gruv-dark-green-light));\n\n\t--info-danger-background: rgba(var(--gruv-dark-red-dark), 0.08);\n\t--info-danger-text: rgba(rgba(gruv-dark-red-light));\n\n\t--info-positive-background: rgba(var(--gruv-dark-green-dark), 0.08);\n\t--info-positive-text: rgba(var(--gruv-dark-green-light));\n\n\t--info-warning-background: rgba(var(--gruv-dark-orange-dark), 0.08);\n\t--info-warning-text: rgba(var(--gruv-dark-text-primary));\n\n\t--background-mod-normal: rgba(var(--gruv-dark-selected-tab));\n\t--background-mod-strong: rgba(var(--gruv-dark-bg2));\n\t--background-mod-subtle: rgba(var(--gruv-dark-bg-soft));\n\n\n\t--interactive-normal: rgba(var(--gruv-dark-icon-color));\n\t--interactive-hover: rgba(var(--gruv-dark-icon-color-hover-harder));\n\t--interactive-active: rgba(var(--gruv-dark-icon-color-hover-harder));\n\t--interactive-muted: rgba(var(--gruv-dark-bg3));\n\n\t--message-reacted-text: rgba(var(--gruv-dark-text-hard));\n\t--message-reacted-background: rgba(var(--gruv-dark-accent), 0.1);\n\n\t--background-message-highlight: rgba(var(--gruv-dark-accent), 0.1);\n\t--background-message-highlight-hover: rgba(var(--gruv-dark-accent), 0.15);\n\n\t--spoiler-hidden-background: rgba(var(--gruv-dark-bg2));\n\t--spoiler-hidden-background-hover: rgba(var(--gruv-dark-bg3));\n\n\t--chat-background-default: rgba(var(--gruv-dark-bg-soft));\n\n\t--premium-nitro-pink-text: rgba(var(--gruv-dark-purple-light));\n\t--guild-boosting-pink: rgba(var(--gruv-dark-purple-light));\n\n\t--spine-default: rgba(var(--gruv-dark-bg4));\n\n\t--app-border-frame: rgba(var(--gruv-dark-border-hover));\n\t\n\t--twitch: rgba(var(--gruv-dark-purple-dark));\n\n\t--brand-260: rgba(var(--gruv-dark-accent-hover), 0.8);\n\t--brand-360: rgba(var(--gruv-dark-accent));\n\t--brand-500: rgba(var(--gruv-dark-accent-hover), 0.8);\n\t--brand-05: rgba(var(--gruv-dark-accent-hover), 0.2);\n\t--white-500: rgba(var(--gruv-dark-text-hard));\n\t--blurple-50: rgba(var(--gruv-dark-accent));\n\t--green-300: rgba(var(--gruv-dark-green-dark));\n\t--green-360: rgba(var(--gruv-dark-green-dark));\n\t--color-total: rgba(var(--gruv-dark-text-muted));\n\t--primary-300: rgba(var(--gruv-dark-text-hard));\n\t--primary-500: rgba(var(--gruv-dark-bg1));\n\n\t--badge-brand-text: rgba(var(--gruv-dark-text-inverted));\n\t--badge-brand-bg: rgba(var(--gruv-dark-accent-hover), 0.8);\n\n\t--redesign-button-positive-background: rgba(var(--gruv-dark-green-dark));\n\t--redesign-button-positive-pressed-background: rgba(var(--gruv-dark-green-dark), 0.8);\n\t--redesign-button-positive-text: rgba(var(--gruv-dark-text-hard));\n}\n\n/* Invite button inside call box */\n.buttonColor__7b3e8 {\n\tcolor: rgba(var(--gruv-dark-text-primary))\n}\n\n/* Input / Output Volume slider (context menu) */\n:where(.visual-refresh) .mini_a562c8 .grabber_a562c8, :where(.visual-refresh) .slider_a562c8 .grabber_a562c8  {\n\tbackground-color: rgba(var(--gruv-dark-text-primary))\n}\n\n[class*=notches_] {\n\tbackground-color: rgba(var(--gruv-dark-bg3))\n}\n\n[class^=control_] [class*=checked_],\n#vc-spotify-player [class*=barFill_] {\n  background-color: rgba(var(--gruv-dark-accent-hover), 0.8) !important;\n}\n\n.slider__87bf1 > rect {\n\tfill: rgba(var(--gruv-dark-text-hard));\n}\n.slider__87bf1 svg > path {\n\tfill: rgba(var(--gruv-dark-bg))\n}\n.container__87bf1 {\n\tbackground-color: rgba(var(--gruv-dark-bg2)) !important\n}\n\n.theme-dark .experimentButton_e131a9.buttonColor_e131a9.buttonActive_e131a9 {\n\tbackground-color: rgba(var(--gruv-dark-green-dark), 0.2);\n}\n\n/* call container bg */\n[class^=callContainer],\n[class^=callContainer] [class^=scroller_] {\n  background-color: rgba(var(--gruv-dark-bg-hard));\n}\n/* Room preview animation */\n.gradientBackground__11664 {\n\tbackground: rgba(var(--gruv-dark-bg)) !important\n}\n.backgroundDark__11664 {\n\tbackground: rgba(var(--gruv-dark-bg)) !important\n}\n.foregroundRing__11664 {\n\tbackground: rgba(var(--gruv-dark-accent-hover), 0.3) !important\n}\n.foregroundBase__11664 {\n\tbackground: rgba(var(--gruv-dark-accent-hover), 1) !important\n}\n\n[mask=\"url(#svg-mask-status-online)\"] {\n  fill: rgba(var(--gruv-dark-status-online));\n}\n\n[mask=\"url(#svg-mask-status-dnd)\"] {\n  fill: rgba(var(--gruv-dark-status-dnd));\n}\n\n[mask=\"url(#svg-mask-status-idle)\"] {\n  fill: var(--gruv-dark-status-idle);\n}\n\n[mask=\"url(#svg-mask-status-offline)\"] {\n  fill: rgba(var(--gruv-dark-status-offline));\n}\n\n\n/*\n   When you are the only in the voice room,\n   sometimes discord will suggest you to invite\n   friends / start activity in the form of \n   user's modal window. This will change its background\n*/\n[class^=callContainer] [class^=root] {\n  background-color: black !important\n}\n\n.flex__7c0ba .lineClamp1__4bd52 {\n\tcolor: rgba(var(--gruv-dark-text-hard)) !important\n}\n\n/* Vesktop plugins / themes */\n.vc-addon-card {\n\tborder: 1px solid rgba(var(--gruv-dark-border-hover))\n}\n\n/* Use solid background for banners in the \"Discover\" category */\n.theme-dark .gradientOverlay_e9ef78,\n.theme-dark .bannerGradient__955a3 {\n\tbackground-color: rgba(var(--gruv-dark-bg));\n\tborder-bottom: 1px solid rgba(var(--gruv-dark-border-hover))\n}\n\n/* ==== Nuked elements ==== */\n\n/* Top to bottom */\n\n/* Quests banner */\n/* Help & Inbox */\n/* Download button */\n.wrapper__0d616,\n.trailing_c38106 {\n\tdisplay: none !important\n}
      '';
    };
  };
}
