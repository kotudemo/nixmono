{
    inputs,
    pkgs,
    ...
}: {
    programs = {
        librewolf = {
            package = pkgs.librewolf;
            profiles = {
              default = {           # choose a profile name; directory is /home/<user>/.mozilla/firefox/profile_0
                id = 0;               # 0 is the default profile; see also option "isDefault"
                name = "default";   # name as listed in about:profiles
                isDefault = true;     # can be omitted; true if profile ID is 0
                extensions = {
                  packages = with pkgs.nur.repos.rycee.firefox-addons; [
                    ublock-origin
                    darkreader
                    sponsorblock
                    istilldontcareaboutcookies
                    decentraleyes
                  ];

                };
                search = {
                  default = "google";
                  force = true;
                  engines = {
                    google = {
                      name = "Google";
                      urls = [{ template = "https://www.google.com/search"; params = [ { name = "q"; value = "{searchTerms}"; } ]; }];
                      icon = "https://www.google.com/favicon.ico";
                      definedAliases = [ "@g" ];
                    };
                    n-pkgs = {
                      name = "NixOS Packages";
                      urls = [{ template = "https://search.nixos.org/packages"; params = [ { name = "query"; value = "{searchTerms}"; } ]; }];
                      icon = "https://search.nixos.org/favicon.png";
                      definedAliases = [ "@np" ];
                    };
                    n-opts = {
                      name = "NixOS Options";
                      urls = [{ template = "https://search.nixos.org/options"; params = [ { name = "query"; value = "{searchTerms}"; } ]; }];
                      icon = "https://search.nixos.org/favicon.png";
                      definedAliases = [ "@no" ];
                    };
                    ddg = {
                      name = "DuckDuckGo";
                      urls = [{ template = "https://duckduckgo.com/"; params = [ { name = "q"; value = "{searchTerms}"; } ]; }];
                      icon = "https://duckduckgo.com/favicon.ico";
                      definedAliases = [ "@d" ];
                    };
                    g-imgs = {
                      name = "Google Images";
                      urls = [{ template = "https://www.google.com/search"; params = [ { name = "tbm"; value = "isch"; }, { name = "q"; value = "{searchTerms}"; } ]; }];
                      icon = "https://www.google.com/favicon.ico";
                      definedAliases = [ "@gi" ];
                    };
                    ya-imgs = {
                      name = "Yandex Images";
                      urls = [{ template = "https://yandex.com/images/search"; params = [ { name = "text"; value = "{searchTerms}"; } ]; }];
                      icon = "https://yandex.com/favicon.ico";
                      definedAliases = [ "@yi" ];
                    };
                    ecosia = {
                      name = "Ecosia";
                      urls = [{ template = "https://www.ecosia.org/search"; params = [ { name = "q"; value = "{searchTerms}"; } ]; }];
                      icon = "https://cdn-static.ecosia.org/static/icons/favicon.ico";
                      definedAliases = [ "@e" ];
                    };
                  };
                };
                extraConfig = ''
                  user_pref("browser.ctrlTab.sortByRecentlyUsed", true)
                  user_pref("content.notify.interval", 100000);

                  user_pref("gfx.canvas.accelerated.cache-items", 4096);
                  user_pref("gfx.canvas.accelerated.cache-size", 512);
                  user_pref("gfx.content.skia-font-cache-size", 20);

                  user_pref("browser.cache.jsbc_compression_level", 3);

                  user_pref("media.memory_cache_max_size", 65536);
                  user_pref("media.cache_readahead_limit", 7200);
                  user_pref("media.cache_resume_threshold", 3600);

                  user_pref("image.mem.decode_bytes_at_a_time", 32768);

                  user_pref("network.http.max-connections", 1800);
                  user_pref("network.http.max-persistent-connections-per-server", 10);
                  user_pref("network.http.max-urgent-start-excessive-connections-per-host", 5);
                  user_pref("network.http.pacing.requests.enabled", false);
                  user_pref("network.dnsCacheExpiration", 3600);
                  user_pref("network.ssl_tokens_cache_capacity", 10240);

                  user_pref("network.dns.disablePrefetch", true);
                  user_pref("network.dns.disablePrefetchFromHTTPS", true);
                  user_pref("network.prefetch-next", false);
                  user_pref("network.predictor.enabled", false);
                  user_pref("network.predictor.enable-prefetch", false);

                  user_pref("dom.enable_web_task_scheduling", true);

                  user_pref("browser.contentblocking.category", "strict");
                  user_pref("urlclassifier.trackingSkipURLs", "*.reddit.com, *.twitter.com, *.twimg.com, *.tiktok.com");
                  user_pref("urlclassifier.features.socialtracking.skipURLs", "*.instagram.com, *.twitter.com, *.twimg.com");
                  user_pref("network.cookie.sameSite.noneRequiresSecure", true);
                  user_pref("browser.download.start_downloads_in_tmp_dir", true);
                  user_pref("browser.helperApps.deleteTempFileOnExit", true);
                  user_pref("browser.uitour.enabled", false);
                  user_pref("privacy.globalprivacycontrol.enabled", true);

                  user_pref("security.OCSP.enabled", 0);
                  user_pref("security.remote_settings.crlite_filters.enabled", true);
                  user_pref("security.pki.crlite_mode", 2);

                  user_pref("security.ssl.treat_unsafe_negotiation_as_broken", true);
                  user_pref("browser.xul.error_pages.expert_bad_cert", true);
                  user_pref("security.tls.enable_0rtt_data", false);

                  user_pref("browser.privatebrowsing.forceMediaMemoryCache", true);
                  user_pref("browser.sessionstore.interval", 60000);

                  user_pref("privacy.history.custom", true);

                  user_pref("browser.urlbar.trimHttps", true);
                  user_pref("browser.urlbar.untrimOnUserInteraction.featureGate", true);
                  user_pref("browser.search.separatePrivateDefault.ui.enabled", true);
                  user_pref("browser.urlbar.update2.engineAliasRefresh", true);
                  user_pref("browser.search.suggest.enabled", false);
                  user_pref("browser.urlbar.quicksuggest.enabled", false);
                  user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);
                  user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false);
                  user_pref("browser.urlbar.groupLabels.enabled", false);
                  user_pref("browser.formfill.enable", false);
                  user_pref("security.insecure_connection_text.enabled", true);
                  user_pref("security.insecure_connection_text.pbmode.enabled", true);
                  user_pref("network.IDN_show_punycode", true);

                  user_pref("dom.security.https_first", true);

                  user_pref("signon.formlessCapture.enabled", false);
                  user_pref("signon.privateBrowsingCapture.enabled", false);
                  user_pref("network.auth.subresource-http-auth-allow", 1);
                  user_pref("editor.truncate_user_pastes", false);

                  user_pref("security.mixed_content.block_display_content", true);
                  user_pref("pdfjs.enableScripting", false);

                  user_pref("extensions.enabledScopes", 5);

                  user_pref("network.http.referer.XOriginTrimmingPolicy", 2);

                  user_pref("privacy.userContext.ui.enabled", true);

                  user_pref("browser.safebrowsing.downloads.remote.enabled", false);

                  user_pref("permissions.default.desktop-notification", 2);
                  user_pref("permissions.default.geo", 2);
                  user_pref("permissions.manager.defaultsUrl", "");
                  user_pref("webchannel.allowObject.urlWhitelist", "");

                  user_pref("datareporting.policy.dataSubmissionEnabled", false);
                  user_pref("datareporting.healthreport.uploadEnabled", false);
                  user_pref("toolkit.telemetry.unified", false);
                  user_pref("toolkit.telemetry.enabled", false);
                  user_pref("toolkit.telemetry.server", "data:,");
                  user_pref("toolkit.telemetry.archive.enabled", false);
                  user_pref("toolkit.telemetry.newProfilePing.enabled", false);
                  user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
                  user_pref("toolkit.telemetry.updatePing.enabled", false);
                  user_pref("toolkit.telemetry.bhrPing.enabled", false);
                  user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
                  user_pref("toolkit.telemetry.coverage.opt-out", true);
                  user_pref("toolkit.coverage.opt-out", true);
                  user_pref("toolkit.coverage.endpoint.base", "");
                  user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
                  user_pref("browser.newtabpage.activity-stream.telemetry", false);

                  user_pref("app.shield.optoutstudies.enabled", false);
                  user_pref("app.normandy.enabled", false);
                  user_pref("app.normandy.api_url", "");

                  user_pref("breakpad.reportURL", "");
                  user_pref("browser.tabs.crashReporting.sendReport", false);
                  user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);

                  user_pref("captivedetect.canonicalURL", "");
                  user_pref("network.captive-portal-service.enabled", false);
                  user_pref("network.connectivity-service.enabled", false);

                  user_pref("browser.privatebrowsing.vpnpromourl", "");
                  user_pref("extensions.getAddons.showPane", false);
                  user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
                  user_pref("browser.discovery.enabled", false);
                  user_pref("browser.shell.checkDefaultBrowser", false);
                  user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
                  user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
                  user_pref("browser.preferences.moreFromMozilla", false);
                  user_pref("browser.aboutConfig.showWarning", false);
                  user_pref("browser.aboutwelcome.enabled", false);
                  user_pref("browser.tabs.tabmanager.enabled", false);
                  user_pref("browser.profiles.enabled", true);

                  user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
                  user_pref("browser.compactmode.show", true);
                  user_pref("browser.display.focus_ring_on_anything", true);
                  user_pref("browser.display.focus_ring_style", 0);
                  user_pref("browser.display.focus_ring_width", 0);
                  user_pref("layout.css.prefers-color-scheme.content-override", 2);
                  user_pref("browser.privateWindowSeparation.enabled", false); // WINDOWS
                  user_pref("browser.newtabpage.activity-stream.newtabWallpapers.v2.enabled", true);

                  user_pref("cookiebanners.service.mode", 1);
                  user_pref("cookiebanners.service.mode.privateBrowsing", 1);

                  user_pref("full-screen-api.transition-duration.enter", "0 0");
                  user_pref("full-screen-api.transition-duration.leave", "0 0");
                  user_pref("full-screen-api.warning.delay", -1);
                  user_pref("full-screen-api.warning.timeout", 0);

                  user_pref("browser.urlbar.suggest.calculator", true);
                  user_pref("browser.urlbar.unitConversion.enabled", true);
                  user_pref("browser.urlbar.trending.featureGate", false);
                  user_pref("dom.text_fragments.enabled", true);

                  user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
                  user_pref("browser.newtabpage.activity-stream.showWeather", false);
                  user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);

                  user_pref("extensions.pocket.enabled", false);

                  user_pref("browser.download.manager.addToRecentDocs", false);

                  user_pref("browser.download.open_pdf_attachments_inline", true);

                  user_pref("browser.bookmarks.openInTabClosesMenu", false);
                  user_pref("browser.menu.showViewImageInfo", true);
                  user_pref("findbar.highlightAll", true);
                  user_pref("layout.word_select.eat_space_to_next_word", false);

                  user_pref("apz.overscroll.enabled", true); // DEFAULT NON-LINUX
                  user_pref("general.smoothScroll", true); // DEFAULT
                  user_pref("general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS", 12);
                  user_pref("general.smoothScroll.msdPhysics.enabled", true);
                  user_pref("general.smoothScroll.msdPhysics.motionBeginSpringConstant", 600);
                  user_pref("general.smoothScroll.msdPhysics.regularSpringConstant", 650);
                  user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaMS", 25);
                  user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaRatio", 2.0);
                  user_pref("general.smoothScroll.msdPhysics.slowdownSpringConstant", 250);
                  user_pref("general.smoothScroll.currentVelocityWeighting", 1.0);
                  user_pref("general.smoothScroll.stopDecelerationWeighting", 1.0);
                  user_pref("mousewheel.default.delta_multiplier_y", 350);
                '';
                bookmarks = {
                  settings = [
                    {
                      name = "YouTube";
                      url = "https://www.youtube.com/";
                      toolbar = true;
                    }
                    {
                      name = "Yandex Translate";
                      url = "https://translate.yandex.com/?lang=en-ru";
                      toolbar = true;
                    }
                    {
                      name = "DeepL Translate";
                      url = "https://www.deepl.com/translator";
                      toolbar = true;
                    }
                    {
                      name = "Pinterest";
                      url = "https://ru.pinterest.com/";
                      toolbar = true;
                    }
                    {
                      name = "Github";
                      url = "https://github.com/";
                      toolbar = true;
                    }
                    {
                      name = "shikimori";
                      url = "https://shikimori.one/";
                      toolbar = true;
                    }
                    {
                      name = "mangalib";
                      url = "https://mangalib.me/?section=home-updates";
                      toolbar = true;
                    }
                    {
                      name = "AnimeGO";
                      url = "https://animego.online/";
                      toolbar = true;
                    }
                    {
                      name = "jutsu";
                      url = "https://jut.su/";
                      toolbar = true;
                    }
                    {
                      name = "AnimeJoy";
                      url = "https://animejoy.ru/";
                      toolbar = true;
                    }
                    {
                      name = "gmail";
                      url = "https://mail.google.com/mail/u/0/#inbox";
                      toolbar = true;
                    }
                    {
                      name = "Firstmail";
                      url = "https://firstmail.ltd/webmail/inbox";
                      toolbar = true;
                    }
                    {
                      name = "protonmail";
                      url = "https://mail.proton.me/u/0/inbox";
                      toolbar = true;
                    }
                    {
                      name = "ChatGPT";
                      url = "https://chatgpt.com/";
                      toolbar = true;
                    }
                    {
                      name = "monkeytype";
                      url = "https://monkeytype.com/";
                      toolbar = true;
                    }
                    {
                      name = "rutracker";
                      url = "https://rutracker.org/forum/index.php";
                      toolbar = true;
                    }
                  ];
                };

              };
            };
        };
    };
}