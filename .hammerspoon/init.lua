-- Setup --
local mash = {"cmd", "alt"}

-- Global keyboard shortcuts --
hs.hotkey.bind(mash, 'J', function() hs.application.launchOrFocus('Google Chrome') end)
hs.hotkey.bind(mash, 'N', function() hs.application.launchOrFocus('Google Chrome Canary') end)
hs.hotkey.bind(mash, 'M', function() hs.application.launchOrFocus('Insomnia') end)
hs.hotkey.bind(mash, 'K', function() hs.application.launchOrFocus('iTerm') end)
hs.hotkey.bind(mash, 'P', function() hs.application.launchOrFocus('TablePlus') end)
hs.hotkey.bind(mash, ';', function() hs.application.launchOrFocus('Slack') end)
hs.hotkey.bind(mash, 'A', function() hs.application.launchOrFocus('Obsidian') end)
hs.hotkey.bind(mash, 'F', function() hs.application.launchOrFocus('Figma') end)
hs.hotkey.bind(mash, 'S', function() hs.application.launchOrFocus('Spark') end)
hs.hotkey.bind(mash, 'C', function() hs.application.launchOrFocus('Asana') end)
hs.hotkey.bind(mash, 'T', function() hs.application.launchOrFocus('Tower') end)
