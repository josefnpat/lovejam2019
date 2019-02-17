io.stdout:setvbuf("no")
love.graphics.setDefaultFilter("nearest","nearest")

love.graphics.setFont(love.graphics.newFont("assets/fonts/VT323-Regular.ttf",18))

colors = require"libs.tic80colors"
playerlib = require"libs.playerlib"
maplib = require"libs.maplib"
dungeonviewlib = require"libs.dungeonviewlib"
mapviewlib = require"libs.mapviewlib"
monsterlib = require"libs.monsterlib"
rocklib = require"libs.rocklib"
loglib = require"libs.loglib"
gamestate = require "libs.gamestate"

states = {
  splash = require"states.splash",
  menu = require"states.menu",
  game = require"states.game",
}

love.graphics.setBackgroundColor(colors.black)

function love.load()
  gamestate.registerEvents()
  gamestate.switch(states.splash)
end

function love.keypressed(key)
  if key == "`" and love.keyboard.isDown("lshift") then
    debug_mode = not debug_mode
  end
end
