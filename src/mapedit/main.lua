io.stdout:setvbuf("no")
local map = {}
local size = 32

local tiles_map = {}
local tile_debug
local walldir = "walls/"
for _,walltype in pairs(love.filesystem.getDirectoryItems(walldir)) do
  local image = love.graphics.newImage(walldir..walltype.."/1.png")
  if walltype == "debug" then
    tile_debug = image
  else
    table.insert(tiles_map,image)
  end
end

function love.load()
  data = {
    {1,2,2,2,1,2,2,2,1,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,},
    {2,0,0,0,2,0,0,0,2,0,0,0,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,},
    {2,0,0,0,0,0,0,0,0,0,0,0,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,},
    {2,0,0,0,2,0,0,0,2,0,0,0,2,1,0,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,},
    {1,2,2,2,2,0,0,0,2,2,2,2,1,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,1,1,1,},
    {2,0,0,0,2,0,0,0,2,0,0,0,2,1,1,1,0,0,0,1,1,0,0,0,1,0,0,0,0,0,1,1,},
    {2,0,0,0,0,0,0,0,0,0,0,0,2,1,0,1,0,1,0,0,0,0,0,1,1,1,1,0,0,0,1,1,},
    {2,0,0,0,2,0,0,0,2,0,0,0,2,1,0,0,0,1,0,1,1,1,0,0,0,0,0,1,0,0,0,1,},
    {1,2,2,2,2,0,0,0,2,2,2,2,1,1,1,1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,1,1,},
    {2,0,0,0,2,0,0,0,2,0,0,0,2,1,1,0,0,0,0,0,0,1,0,0,1,1,0,1,1,0,1,1,},
    {2,0,0,0,0,0,0,0,0,0,0,0,2,1,0,0,1,0,1,0,0,1,0,0,0,0,0,0,0,0,1,1,},
    {2,0,0,0,2,0,0,0,2,0,0,0,2,1,0,1,1,0,0,0,0,0,1,1,0,0,1,0,0,1,1,1,},
    {1,2,2,2,2,0,0,0,2,2,2,2,2,1,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,1,1,},
    {1,1,2,0,0,0,0,0,0,0,2,1,1,0,1,0,1,0,1,0,1,0,0,0,0,1,0,0,0,0,1,1,},
    {1,1,2,0,0,1,0,1,0,0,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,1,1,},
    {1,1,2,0,0,1,1,1,0,0,2,1,1,1,0,1,0,1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,},
    {1,1,2,0,0,1,1,1,0,0,2,1,0,0,0,1,0,0,0,0,0,0,1,0,1,0,0,0,1,2,2,2,},
    {1,1,2,0,0,1,1,1,0,0,2,1,0,0,0,0,0,0,1,1,1,0,0,0,0,1,1,0,0,0,0,2,},
    {1,2,2,0,0,1,1,1,0,0,2,1,1,1,1,0,1,0,1,0,0,1,0,0,0,0,0,0,0,2,0,2,},
    {2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,1,0,1,2,0,2,},
    {2,0,2,0,0,0,0,0,0,0,2,0,0,1,1,1,1,1,0,1,0,1,0,1,0,0,0,1,1,2,0,2,},
    {2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,0,1,0,0,1,0,0,1,1,2,0,2,},
    {1,2,2,2,2,2,0,2,2,2,2,1,1,0,0,1,0,0,0,1,1,1,0,1,0,0,0,1,1,2,0,2,},
    {1,1,1,1,2,0,0,0,2,1,1,1,1,1,0,0,0,1,1,0,0,0,0,0,0,0,1,0,1,2,0,2,},
    {1,1,1,1,2,0,0,0,2,1,1,1,1,1,0,0,1,0,0,0,1,0,1,0,1,0,0,0,1,2,0,2,},
    {1,1,1,1,2,0,0,0,2,1,1,1,1,1,1,1,0,0,0,1,0,1,0,0,0,0,1,0,1,2,0,2,},
    {1,1,1,2,0,0,1,0,0,2,1,1,1,1,1,0,0,0,1,0,0,0,0,1,1,0,1,0,1,2,0,2,},
    {1,1,1,2,0,0,0,0,0,2,1,1,1,1,2,0,2,0,0,0,0,1,0,0,0,0,0,0,0,0,0,2,},
    {1,1,1,1,2,0,0,0,2,1,1,1,1,1,2,0,2,1,1,1,1,1,1,0,1,1,1,1,1,2,0,2,},
    {1,1,1,1,1,2,2,2,1,1,1,1,1,1,2,0,2,2,2,2,2,2,2,0,2,2,2,2,2,2,0,2,},
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,},
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,},
  }
  map = data
end

function love.draw()
  for x = 1,size do
    for y = 1,size do
      local val = map[x][y]
      local image = tiles_map[val] or tile_debug
      if val > 0 then
        love.graphics.draw(image,x*16,y*16)
      end
    end
  end
end

function love.mousepressed(mx,my,button)
  if button == 1 then
    local x,y = math.floor(mx/16),math.floor(my/16)
    if map[x] and map[x][y] then
      map[x][y] = map[x][y] + 1
      if map[x][y] > #tiles_map then
        map[x][y] = 0
      end
    end
  end
end

function love.update(dt)
  if love.mouse.isDown(2) then
    local mx,my = love.mouse.getPosition()
    local x,y = math.floor(mx/16),math.floor(my/16)
    if map[x] and map[x][y] then
      map[x][y] = 0
    end
  end
end

function love.keypressed()
  io.write("data = {\n")
  for x = 1,size do
    io.write("  {")
    for y = 1,size do
      io.write(map[x][y]..",")
    end
    io.write("},\n")
  end
  io.write("}\n")
end
