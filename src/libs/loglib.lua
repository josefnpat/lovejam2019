local loglib = {}

function loglib.new(init)
  init = init or {}
  local self = {}

  self.draw = loglib.draw
  self.add = loglib.add

  self._data = {}

  return self
end

function loglib:draw(x,y,w,h)
  love.graphics.setScissor(x,y,w,h)
  local ftext = ""
  for _,text in pairs(self._data) do
    ftext = text .. "\n" .. ftext
  end
  love.graphics.setColor(colors.red)
  love.graphics.printf(ftext,x+1,y+1,w,"center")
  love.graphics.setColor(colors.black)
  love.graphics.printf(ftext,x,y,w,"center")
  love.graphics.setColor(1,1,1)
  love.graphics.setScissor()
end

function loglib:add(text)
  table.insert(self._data,text)
end

return loglib
