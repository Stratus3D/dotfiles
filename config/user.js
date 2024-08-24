// This is a config file for the Firefox web browser. It's intended to override
// default config contained in a Firefox profile. It should be placed inside the
// directory of the particular profile you are using. For example, on MacOS for
// me this is:
//
// /Users/trevorbrown/Library/Application\ Support/Firefox/Profiles/15r2l41x.default-release/
//
// Links
//
// * https://askubuntu.com/questions/313483/how-do-i-change-firefoxs-aboutconfig-from-a-shell-script
// * http://kb.mozillazine.org/User.js_file

// Don't ever show bookmarks toolbar. I'm on the fence about this. Bookmarks
// tool can be nice at times
user_pref("browser.toolbars.bookmarks.visibility", "never")

// Don't show page when opening new tab. Show blank white tab
user_pref("browser.newtabpage.enabled", false)

// Require interaction with notifications before dismissing them. Makes it
// harder to overlook important notifications
user_pref("dom.webnotifications.requireinteraction.enabled", true);

// Don't show ads in suggestions
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false)

// Zoom with Meta + mousewheel
user_pref("mousewheel.with_meta.action.override_x", 3)
