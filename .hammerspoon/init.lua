-- Setup --
local mash = {"cmd", "alt"}

-- Global keyboard shortcuts --
hs.hotkey.bind(mash, 'H', function() hs.application.launchOrFocus('Google Chrome') end)
hs.hotkey.bind(mash, 'I', function() hs.application.launchOrFocus('iTerm') end)
hs.hotkey.bind(mash, 'P', function() hs.application.launchOrFocus('Spotify') end)
hs.hotkey.bind(mash, 'U', function() hs.application.launchOrFocus('Firefox') end)
hs.hotkey.bind(mash, 'J', function() hs.application.launchOrFocus('Visual Studio Code') end)
hs.hotkey.bind(mash, 'O', function() hs.application.launchOrFocus('Slack') end)
hs.hotkey.bind(mash, 'N', function() hs.application.launchOrFocus('Notion') end)
hs.hotkey.bind(mash, 'M', function() hs.application.launchOrFocus('Mail') end)

