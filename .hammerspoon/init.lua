-- Setup --
local mash = {"cmd", "alt"}

-- Global keyboard shortcuts --
hs.hotkey.bind(mash, 'J', function() hs.application.launchOrFocus('Google Chrome') end)
hs.hotkey.bind(mash, 'M', function() hs.application.launchOrFocus('Preview') end)
hs.hotkey.bind(mash, 'K', function() hs.application.launchOrFocus('iTerm') end)
hs.hotkey.bind(mash, 'P', function() hs.application.launchOrFocus('Spotify') end)
hs.hotkey.bind(mash, 'L', function() hs.application.launchOrFocus('Slack') end)
hs.hotkey.bind(mash, 'H', function() hs.application.launchOrFocus('TickTick') end)
hs.hotkey.bind(mash, 'U', function() hs.application.launchOrFocus('Quiver') end)
hs.hotkey.bind(mash, ',', function() hs.application.launchOrFocus('Dash') end)
