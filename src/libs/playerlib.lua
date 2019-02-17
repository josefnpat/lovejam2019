local playerlib = {}

function playerlib.new(init)
  init = init or {}
  local self = {}

  self._map = init.map
  self._characters = init.characters

  self.getX = playerlib.getX
  self.setX = playerlib.setX
  self._x = init.x

  self.getY = playerlib.getY
  self.setY = playerlib.setY
  self._y = init.y

  self.getRotation = playerlib.getRotation
  self.setRotation = playerlib.setRotation
  self._rotation = init.rotation

  self._rocks = 0

  self.draw = playerlib.draw
  self.getPerspectiveVector = playerlib.getPerspectiveVector
  self.move = playerlib.move
  self.moveForward = playerlib.moveForward
  self.moveLeft = playerlib.moveLeft
  self.moveRight = playerlib.moveRight
  self.moveBackwards = playerlib.moveBackwards
  self.turnLeft = playerlib.turnLeft
  self.turnRight = playerlib.turnRight

  return self
end

function playerlib:getX()
  return self._x
end

function playerlib:setX(val)
  self._x = val
end

function playerlib:getY()
  return self._y
end

function playerlib:setY(val)
  self._y = val
end

function playerlib:getRotation()
  return self._rotation
end

function playerlib:setRotation(val)
  self._rotation = val
end

function playerlib:draw(x,y)
end

function playerlib:getPerspectiveVector(r)
  r = r or self._rotation
  local rotation = r%4
  if rotation == 0 then
    return 1,0
  elseif rotation == 1 then
    return 0,1
  elseif rotation == 2 then
    return -1,0
  elseif rotation == 3 then
    return 0,-1
  end
end

local rocklines = {
  "I found a large rock.",
  "This is a big rock.",
  "This rock is heavy, but I've got it.",
  "Whof, heavy rock.",
  "Ugh, my back. Rocks.",
  "Why do I do this for rocks?",
  "More rocks.",
  "Rocks rocks rocks.",
}

local taskmasterlines_many = {
  "For $x rocks, you get $x morsels.",
  "I see you have $x rocks. Begone.",
  "Only $x rocks? Awful.",
  "$x rocks? Only $x rocks? Get more rocks!",
  "This dumb dwarf only found $x rocks."
}

local taskmasterlines_one = {
  "Only one rock? Awful.",
  "What am I supposed to with one rock?",
  "That's it? Miserable dwarf.",
}

function playerlib:move(ox,oy)
  local tx,ty = self._x + ox, self._y + oy
  local tile = self._map:getTile(tx,ty)
  local monster = tile:getMonster()
  if monster then
    if monster._type == "rock" then
      if self._rocks < 4 then
        self._rocks = self._rocks + 1
        log:add(rocklines[math.random(#rocklines)].. " -Gild")
        tile:setMonster()
        self._gild_instructions = nil
      else
        if self._gild_instructions == nil then
          self._gild_instructions = true
          log:add("I can't carry any more rocks. -Gild")
        end
      end
    elseif monster._name == "taskmaster" then
      if self._rocks > 0 then

        local linesource = self._rocks == 1 and taskmasterlines_one or taskmasterlines_many

        local line = linesource[math.random(#linesource)] .. " -Taskmaster"
        log:add(line:gsub("$x",self._rocks))
        self._rocks = 0
        self._taskmaster_instructions = nil
      else
        if self._taskmaster_instructions == nil then
          self._taskmaster_instructions = true
          log:add("Go find more rocks! -Taskmaster")
        end
      end
    end
  elseif tile:getType() == 0 then
    self._x,self._y = tx,ty
  end
end

function playerlib:moveForward()
  self:move(self:getPerspectiveVector(self._rotation))
end

function playerlib:moveLeft()
  self:move(self:getPerspectiveVector(self._rotation-1))
end

function playerlib:moveRight()
  self:move(self:getPerspectiveVector(self._rotation+1))
end

function playerlib:moveBackwards()
  self:move(self:getPerspectiveVector(self._rotation+2))
end

function playerlib:turnLeft()
  self._rotation = (self._rotation - 1)%4
end

function playerlib:turnRight()
  self._rotation = (self._rotation + 1)%4
end

return playerlib
