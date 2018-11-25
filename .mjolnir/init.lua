-- Setup --
local application = require "mjolnir.application"
local hotkey = require "mjolnir.hotkey"

local mash = {"cmd", "alt", "ctrl"}

-- Global keyboard shortcuts --
hotkey.bind(mash, 'G', function() application.launchorfocus('Google Chrome') end)
hotkey.bind(mash, 'I', function() application.launchorfocus('iTerm') end)
hotkey.bind(mash, 'P', function() application.launchorfocus('Spotify') end)
hotkey.bind(mash, 'S', function() application.launchorfocus('Firefox') end)
hotkey.bind(mash, 'C', function() application.launchorfocus('Visual Studio Code') end)
hotkey.bind(mash, 'K', function() application.launchorfocus('Slack') end)
hotkey.bind(mash, 'N', function() application.launchorfocus('Notion') end)
hotkey.bind(mash, 'M', function() application.launchorfocus('Mail') end)

