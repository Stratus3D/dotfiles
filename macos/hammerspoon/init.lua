-- From https://github.com/peterklijn/hammerspoon-shiftit

hs.loadSpoon("ShiftIt")
spoon.ShiftIt:bindHotkeys({
  left = {{'cmd'}, 'left' },
  right = {{'cmd'}, 'right' },
  up = {{'cmd'}, 'up' },
  down = {{'cmd'}, 'down' },
  upleft = {{ 'ctrl', 'alt', 'cmd' }, '1' },
  upright = {{ 'ctrl', 'alt', 'cmd' }, '2' },
  botleft = {{ 'ctrl', 'alt', 'cmd' }, '3' },
  botright = {{ 'ctrl', 'alt', 'cmd' }, '4' },
  maximum = {{ 'ctrl', 'alt', 'cmd' }, 'm' },
  toggleFullScreen = {{ 'ctrl', 'alt', 'cmd' }, 'f' },
  toggleZoom = {{ 'ctrl', 'alt', 'cmd' }, 'z' },
  center = {{ 'ctrl', 'alt', 'cmd' }, 'c' },
  nextScreen = {{ 'ctrl', 'alt', 'cmd' }, 'n' },
  previousScreen = {{ 'ctrl', 'alt', 'cmd' }, 'p' },
  resizeOut = {{ 'ctrl', 'alt', 'cmd' }, '=' },
  resizeIn = {{ 'ctrl', 'alt', 'cmd' }, '-' }
})

-- From https://rakhesh.com/coding/using-hammerspoon-to-switch-apps/
-- For finder run Opt-Cmd-Space
ctrlCmdShortcuts = {
    {"A", "Terminal"},
    {"S", "Firefox"},
    {"D", "Slack"},
    {"F", "Postman"},
    {"G", "DBeaver"},
}

for i,shortcut in ipairs(ctrlCmdShortcuts) do
    hs.hotkey.bind({"ctrl","cmd"}, shortcut[1], function()
        hs.application.launchOrFocus(shortcut[2])
    end)
end
