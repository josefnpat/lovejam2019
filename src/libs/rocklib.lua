local rocklib = {}

local _images = {}
local dir = "assets/monsters/rock/"
for i,perspective in pairs(love.filesystem.getDirectoryItems(dir)) do
  _images[i] = love.graphics.newImage(dir..perspective)
end

function rocklib.new(init)
  init = init or {}
  local self = require("libs.entitylib").new(init)

  self.getPerspectiveImage = rocklib.getPerspectiveImage
  self.update = rocklib.update

  self._type = "rock"

  return self
end

function rocklib:getPerspectiveImage(pers)
  return _images[pers]
end

function rocklib:update(dt)
end

return rocklib
