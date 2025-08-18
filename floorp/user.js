// Floorp User Preferences Configuration
// Place this file in your profile directory as user.js

// Browser startup settings
user_pref("browser.startup.homepage", "about:home");

// Disable irritating first-run stuff
user_pref("browser.disableResetPrompt", true);
user_pref("browser.download.panel.shown", true);
user_pref("browser.feeds.showFirstRunUI", false);
user_pref("browser.messaging-system.whatsNewPanel.enabled", false);
user_pref("browser.rights.3.shown", true);
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("browser.shell.defaultBrowserCheckCount", 1);
user_pref("browser.startup.homepage_override.mstone", "ignore");
user_pref("browser.uitour.enabled", false);
user_pref("startup.homepage_override_url", "");
user_pref("trailhead.firstrun.didSeeAboutWelcome", true);
user_pref("browser.bookmarks.restore_default_bookmarks", false);
user_pref("browser.bookmarks.addedImportButton", true);

// Download settings
user_pref("browser.download.useDownloadDir", true);
user_pref("browser.download.open_pdf_attachments_inline", true);

// UI customizations
user_pref("browser.compactmode.show", true);
user_pref("floorp.browser.user.interface", 8); // Floorp Fluerial UI
user_pref("widget.non-native-theme.scrollbar.style", 3);
user_pref("apz.overscroll.enabled", false); // No overscroll animations at the top

// Image cache
user_pref("image.mem.surfacecache.max_size_kb", 500000);

// New tab page settings
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts", false);
user_pref("browser.newtabpage.activity-stream.floorp.newtab.imagecredit.hide", true);
user_pref("browser.newtabpage.activity-stream.floorp.newtab.releasenote.hide", true);

// Block specific top sites
user_pref("browser.newtabpage.blocked", "26UbzFJ7qT9/4DhodHKA1Q==,4gPpjkxgZzXPVtuEoAL9Ig==,eV8/WsSLxHadrTL1gAxhug==,gLv0ja2RYVgxKdp0I5qwvA==,K00ILysCaEq8+bEqV/3nuw==,T9nJot5PurhJSy8n038xGA==");

// Tab settings
user_pref("browser.tabs.insertAfterCurrent", true);
user_pref("browser.newtabpage.activity-stream.floorp.background.image.path", "~/Pictures/wallpapers/browser.jpg");
user_pref("browser.newtabpage.activity-stream.floorp.background.type", 4); // Image

// Disable telemetry
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("browser.discovery.enabled", false);
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
user_pref("browser.ping-centre.telemetry", false);
user_pref("datareporting.healthreport.service.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("datareporting.sessions.current.clean", true);
user_pref("devtools.onboarding.telemetry.logged", false);
user_pref("extensions.htmlaboutaddons.discover.enabled", false);
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.hybridContent.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.prompted", 2);
user_pref("toolkit.telemetry.rejected", true);
user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);
user_pref("toolkit.telemetry.server", "");
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.unifiedIsOptIn", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);

// Disable addons recommendations
user_pref("extensions.getAddons.showPane", false);
user_pref("extensions.webservice.discoverURL", "");
user_pref("extensions.getAddons.discovery.api_url", "");

// Media settings
user_pref("media.block-autoplay-until-in-foreground", true);
user_pref("media.block-play-until-document-interaction", true);
user_pref("media.block-play-until-visible", true);

// Layout settings
user_pref("layout.word_select.eat_space_to_next_word", true);

// Don't show prompt to save password
user_pref("signon.rememberSignons", false);

// Identity settings
user_pref("identity.fxaccounts.enabled", true);
user_pref("identity.fxaccounts.account.device.name", "linux-desktop");

// Security/Privacy settings
user_pref("privacy.trackingprotection.enabled", true);
user_pref("dom.security.https_only_mode", true);

// UI Customization state
user_pref("browser.uiCustomization.state", "{\"currentVersion\":20,\"newElementCount\":5,\"dirtyAreaCache\":[\"nav-bar\",\"PersonalToolbar\",\"toolbar-menubar\",\"TabsToolbar\",\"widget-overflow-fixed-list\"],\"placements\":{\"PersonalToolbar\":[\"personal-bookmarks\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"nav-bar\":[\"back-button\",\"forward-button\",\"vertical-spacer\",\"stop-reload-button\",\"urlbar-container\",\"downloads-button\",\"ublock0_raymondhill_net-browser-action\",\"_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action\",\"_testpilot-containers-browser-action\",\"reset-pbm-toolbar-button\",\"unified-extensions-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"unified-extensions-area\":[],\"widget-overflow-fixed-list\":[]},\"seen\":[\"save-to-pocket-button\",\"developer-button\",\"ublock0_raymondhill_net-browser-action\",\"_testpilot-containers-browser-action\"]}");

// Theme
user_pref("extensions.activeThemeID", "firefox-compact-dark@mozilla.org");
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
user_pref("font.name.monospace.x-western", "BlexMono Nerd Font Mono")
user_pref("font.name.sans-serif.x-western", "IBM Plex Sans")
user_pref("font.name.serif.x-western", "IBM Plex Serif")

// Disable workspaces
user_pref("floorp.workspaces.enabled", false)
user_pref("floorp.workspaces.v4.store", {})
user_pref("widget.disable-workspace-management", true)
