local game = {}

function game:init()
  scroll = love.graphics.newImage("assets/scroll.png")
end

function game:enter()

  local map = maplib.new{
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
  }

  entities = {}

  local taskmaster = monsterlib.new{
    name="taskmaster",
    x=7,
    y=15,
  }
  map:getTile(taskmaster._x,taskmaster._y):setMonster(taskmaster)
  table.insert(entities,taskmaster)

  for i = 1,64 do
    local rx,ry = map:findRandomEmptyTile()
    local rock = rocklib.new{
      x=rx,
      y=ty,
    }
    local tile = map:getTile(rx,ry)
    tile:setMonster(rock)
    table.insert(entities,rock)
  end

  player = playerlib.new{
    x = 11,
    y = 3,
    rotation = 2,
    map = map,
  }

  dungeonview = dungeonviewlib.new{
    map = map,
    player = player,
    scale = game_scale,
  }

  mapview = mapviewlib.new{
    map = map,
    player = player,
  }

  log = loglib.new{}

  day = 1979

  log:add("Day "..day..": I am still a prisoner. -Gild")

end

function game:draw()
  --love.graphics.draw(background)
  dungeonview:draw(
    (love.graphics.getWidth()-dungeonview:getWidth())/2,
    (love.graphics.getHeight()-dungeonview:getHeight())/2)
  local mw,mh = 192,88
  local mx,my = dungeonview:getWidth()+mw/2,dungeonview:getHeight()+mh/2
  local size = 5
  mapview:draw((size+2)*16,(size+2)*16,size,size)
  player:draw(dungeonview:getWidth(),0)
  local lw = 320
  local lh = 512-128
  local lx = 64--(love.graphics.getWidth()-lw)/4
  local ly = (size*2+2)*16+64--(love.graphics.getHeight()-lh)*3/4

  love.graphics.draw(scroll,lx-64,ly-64)
  log:draw(lx,ly,lw,lh)

  if debug_mode then
    love.graphics.print("x:"..player:getX()..",y:"..player:getY())
  end
end

day_dt = 0

local daylines = {
  "I am very tired.",
  "I miss Calin.",
  "I hate that taskmaster.",
  "I need to find more rocks.",
  "I am hungry.",
  "How can I get out of here?",
  "Is there any hope?",
  "I wish I had a beer.",
  "Where am I?",
  "I miss my pipe.",
  "My arms ache.",
  "My back aches.",
  "My legs ache.",
  "I feel dizzy.",
  "I want to go home.",
  "I miss the tavern at Dureg.",
  "I recall the waitstaff at the Prancing Pony being the best.",
  "I must go to Condor to find the wizard, Macross.",
}

function game:update(dt)

  day_dt = day_dt + dt
  if day_dt > 15 then
    day_dt = 0
    day = day + 1
    log:add("Day "..day..": "..(daylines[math.random(#daylines)]).." -Gild")
  end

  dungeonview:update(dt)
  mapview:update(dt)
  for _,monster in pairs(entities) do
    monster:update(dt)
  end
end

function game:keypressed(key)
  if key == "`" and love.keyboard.isDown("lshift") then
    debug_mode = not debug_mode
  end
  if key == "w" or key == "up" then
    player:moveForward()
  elseif key == "a" then
    player:moveLeft()
  elseif key == "d" then
    player:moveRight()
  elseif key == "s" or key == "down" then
    player:moveBackwards()
  elseif key == "q" or key == "left" then
    player:turnLeft()
  elseif key == "e" or key == "right" then
    player:turnRight()
  elseif key == "-" then
    game_scale = math.max(1,game_scale-1)
    dungeonview:setScale(game_scale)
  elseif key == "=" then
    game_scale = game_scale + 1
    dungeonview:setScale(game_scale)
  end
end

return game
