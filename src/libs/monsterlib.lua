local monsterlib = {}

function monsterlib.new(init)
  init = init or {}
  local self = require("libs.entitylib").new(init)

  self.getPerspectiveImage = monsterlib.getPerspectiveImage
  self.update = monsterlib.update

  self._name = init.name

  self._done_yelling = false

  self._images = {}
  local dir = "assets/monsters/"..self._name.."/"
  for i,perspective in pairs(love.filesystem.getDirectoryItems(dir)) do
    self._images[i] = love.graphics.newImage(dir..perspective)
  end

  return self
end

function monsterlib:getPerspectiveImage(pers)
  return self._images[pers]
end

function monsterlib:update(dt)
  if self._done_yelling == false then
    if self:distance(player) <= 2 then
      self._done_yelling = true
      log:add("Hey, you lazy dwarf! Get back to work. Bring me rocks, or no food! -Taskmaster")
    end
  else
    -- todo: move randomly
  end
end

return monsterlib
