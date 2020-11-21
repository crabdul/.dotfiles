-- Setup --
local mash = {"cmd", "alt"}

-- Global keyboard shortcuts --
hs.hotkey.bind(mash, 'J', function() hs.application.launchOrFocus('Google Chrome') end)
hs.hotkey.bind(mash, 'M', function() hs.application.launchOrFocus('Insomnia') end)
hs.hotkey.bind(mash, 'K', function() hs.application.launchOrFocus('iTerm') end)
hs.hotkey.bind(mash, 'P', function() hs.application.launchOrFocus('Postico') end)
hs.hotkey.bind(mash, 'L', function() hs.application.launchOrFocus('Slack') end)
hs.hotkey.bind(mash, 'W', function() hs.application.launchOrFocus('Safari') end)
hs.hotkey.bind(mash, 'U', function() hs.application.launchOrFocus('Quiver') end)
hs.hotkey.bind(mash, 'N', function() hs.application.launchOrFocus('SnippetsLab') end)
hs.hotkey.bind(mash, 'Y', function() hs.application.launchOrFocus('Visual Studio Code') end)
