git_hash,git_count = "missing git.lua",-1
pcall( function() return require("git") end );
game_scale = 5

function love.conf(t)
  t.identity = "DungeonsAndGild"
  t.window.width = 1280
  t.window.height = 720
  t.window.title = "Dungeons & Gild"
  t.window.resizable = true
end
