local menu = {}

function menu:init()
  self.music = love.audio.newSource("assets/music.mp3","stream")
  self.music:setVolume(0.25)
  self.music:setLooping(true)
  self.music:play()
end

function menu:enter()
  self._current = 1
end

local story =
  "Dungeons & Gild\n\n"..
  "\"To anyone that finds this, I have been imprisoned by the dungeon trolls. "..
  "They force me to mine. I do not expect to ever escape, but if by luck "..
  "this message does, please save me or I will surely perish.\n\n -Yours, Gild\""

local credits =
  "The game is not about escape, but about the narrative of being imprisoned.\n"..
  "This game was made for the #lovejam2019 in an afternoon.\n"..
  "Code, Art, etc - @josefnpat\n"..
  "Music - Arjan <3\n"..
  ""


local options = {
  {
    text = "I will survive.",
    action = function()
      gamestate.switch(states.game)
    end,
  },
  {
    text = "Show me more!",
    action = function()
      love.system.openURL("http://missingsentinelsoftware.com/")
    end,
  },
  {
    text = "I want to stalk you.",
    action = function()
      love.system.openURL("http://twitter.com/josefnpat")
    end,
  },
  {
    text = "This game rocks!",
    action = function()
      love.system.openURL("http://twitter.com/home?status=@josefnpat Dungeons %26 Gild rocks!")
    end,
  },
  {
    text = "This game rocks! (Pun not intended)",
    action = function()
      love.system.openURL("http://twitter.com/home?status=@josefnpat Dungeons %26 Gild rocks! (Pun not intended)")
    end,
  },
  {
    text = "This game sucks!",
    action = function()
      love.system.openURL("http://twitter.com/home?status=@josefnpat Dungeons %26 Gild sucks!")
    end,
  },
  {
    text = "I surrender.",
    action = function()
      love.event.quit()
    end,
  }
}

function menu:draw()

  love.graphics.setColor(colors.white)
  love.graphics.printf(story,
    love.graphics.getWidth()/4,
    love.graphics.getHeight()/4,
    love.graphics.getWidth()/2,
    "left"
  )

  love.graphics.setColor(colors.light_gray)
  love.graphics.printf(credits,
    love.graphics.getWidth()/4,
    love.graphics.getHeight()*3/4,
    love.graphics.getWidth()/2,
    "left"
  )

  for i,option in pairs(options) do
    local pre
    if i == self._current then
      pre = "> "
      love.graphics.setColor(colors.red)
    else
      pre = ""
      love.graphics.setColor(colors.white)
    end
    love.graphics.print(pre .. option.text,
      love.graphics.getWidth()/4,
      love.graphics.getHeight()/2+16*(i-1))
  end

  love.graphics.setColor(1,1,1)

end

function menu:keypressed(key)
  if key == "up" or key == "w" then
    self._current = self._current - 1
    if self._current <= 0 then
      self._current = #options
    end
  elseif key == "down" or key == "s" then
    self._current = self._current + 1
    if self._current > #options then
      self._current = 1
    end
  elseif key == "return" or key == "space" then
    options[self._current].action()
  end
end

return menu
