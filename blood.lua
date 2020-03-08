local blood = {}
blood.img = love.graphics.newImage('images/redblood.png')
blood.imgi = love.graphics.newImage('images/yellowblood.png')
BLOODSCALE = 0.06

ListBlood = {}

local bloodTic



function BloodInit()
    BloodClean()
end



function BloodUpdate(dt)
    bloodTic = bloodTic + 1

    -- Spawn de sang
    local timeSpawnBlood = math.random(5, 11)
    if bloodTic >= timeSpawnBlood then
        bloodTic = 0
        AddBlood()
    end

    -- Déplacement des sang
    for i = 1, #ListBlood do
        local myBlood = ListBlood[i]
        myBlood.X = myBlood.X + myBlood.Vx
        myBlood.Y = myBlood.Y + myBlood.Vy
    end

    -- Suppression des sang hors jeu
    for i = #ListBlood, 1, -1 do
        local myBlood = ListBlood[i]
        if myBlood.X < 0 - (blood.img:getWidth() * BLOODSCALE) then
            table.remove(ListBlood, i)
        end
    end
end



function BloodDraw()
    for i = 1, #ListBlood do
        local myBlood = ListBlood[i]
        love.graphics.draw(
            myBlood.img,
            myBlood.X,
            myBlood.Y,
            0,
            BLOODSCALE,
            BLOODSCALE,
            blood.img:getWidth() / 2,
            blood.img:getHeight() / 2)
    end
end



function AddBlood()
    local myBlood = {}
    myBlood.X = WIDTH + (blood.img:getWidth() * BLOODSCALE)
    myBlood.Y = HEIGHT - ((blood.img:getHeight() / 2) * BLOODSCALE)
    myBlood.Vx = -5
    myBlood.Vy = 0
    local randImg = math.random(0, 100)
    if randImg <= Health then
        myBlood.img = blood.img
    else
        myBlood.img = blood.imgi
    end
    table.insert(ListBlood, myBlood)
    return myBlood
end

function BloodClean()
    ListBlood = {}
    
    for i = 1, 25 do
        local randBlood = math.random(31, 32)
        AddBlood().X = WIDTH + (blood.img:getWidth() * BLOODSCALE) - (i * randBlood)
    end
    bloodTic = 0
end
