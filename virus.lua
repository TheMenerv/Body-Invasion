local virus = {}
virus.img = love.graphics.newImage('images/virus.png')
VIRUSSCALE = 0.3

local moveTic
local spawnTic



function VirusInit()
    VirusClean()
end



function VirusUpdate(dt)
    moveTic = moveTic + 1
    spawnTic = spawnTic + 1

    -- Rotation et déplacement des virus
    for i = 1, #ListVirus do
        local myVirus = ListVirus[i]

        -- changement de comportement ?
        if moveTic == 25 then
            -- VirusChangeRotation(myVirus)
            VirusMove(myVirus)
        end

        -- rotation
        myVirus.angle = myVirus.angle + myVirus.rotation
        if myVirus.angle < 0 then
            myVirus.angle = 360 + myVirus.angle
        elseif myVirus.angle > 360 then
            myVirus.angle = 0 + (myVirus.angle - 360)
        end

        -- déplacement
        myVirus.X = myVirus.X + myVirus.Vx
        myVirus.Y = myVirus.Y + myVirus.Vy

        -- collision avec le joueur
        local contact = IsInPlayer(myVirus.X, myVirus.Y)
        if contact then
            crop:play()
            myVirus.toDelete = true
            PLAYERSCALE = PLAYERSCALE + 0.02
            if PLAYERSCALE >= MAXPLAYERSCALE then
                PLAYERSCALE = MAXPLAYERSCALE
            end
        end

        -- collision avec les bords
        if myVirus.X <= ((virus.img:getWidth() / 2) * VIRUSSCALE) and myVirus.Vx < 0 then
            myVirus.X = ((virus.img:getWidth() / 2) * VIRUSSCALE)
            myVirus.Vx = 0 - myVirus.Vx
        end
        if myVirus.X >= WIDTH - ((virus.img:getWidth() / 2) * VIRUSSCALE) and myVirus.Vx > 0 then
            myVirus.X = WIDTH - ((virus.img:getWidth() / 2) * VIRUSSCALE)
            myVirus.Vx = 0 - myVirus.Vx
        end

        -- attaque
        if myVirus.Y >= HEIGHT - VEINEPOSITION and myVirus.attacked == false then
            myVirus.attacked = true
            ouie:play()
            local damage = math.random(3, 7)
            Health = Health - damage
            if Health <= 0 then
                Health = 0
                Scene = "gameover"
            end
            PLAYERSCALE = PLAYERSCALE - (1 / (20 - damage))
            if PLAYERSCALE <= MINPLAYERSCALE then
            PLAYERSCALE = MINPLAYERSCALE
            end
        end
    end

    if moveTic == 25 then
        moveTic = 0
    end

    -- Suppression des virus hors jeu
    for i = #ListVirus, 1, -1 do
        local myVirus = ListVirus[i]
        if myVirus.Y > HEIGHT + ((virus.img:getHeight() / 2) * VIRUSSCALE) or myVirus.toDelete then
            table.remove(ListVirus, i)
        end
    end

    -- Spawn de virus
    if spawnTic >= 50 then
        spawnTic = 0
        if math.random() <= Difficulty then
            AddVirus()
        end
        Difficulty = Difficulty + 0.005
        if Difficulty > 1 then
            Difficulty = 1
        end
    end
end



function VirusDraw()
    for i = 1, #ListVirus do
        local myVirus = ListVirus[i]
        love.graphics.draw(virus.img, myVirus.X, myVirus.Y, myVirus.angle / math.pi, VIRUSSCALE, VIRUSSCALE, virus.img:getWidth() / 2, virus.img:getHeight() / 2)
    end
end



function AddVirus()
    local myVirus = {}
    myVirus.X = math.random(0 + ((virus.img:getWidth() * VIRUSSCALE) / 2), WIDTH - ((virus.img:getWidth() * VIRUSSCALE) / 2))
    myVirus.Y = 0 - ((virus.img:getHeight() / 2) * VIRUSSCALE)
    myVirus.angle = 0 --math.random(360)
    myVirus.Vx = 0
    myVirus.Vy = 0
    myVirus.attacked = false
    myVirus.toDelete = false
    myVirus.rotation = 0 --math.random(-10, 10)/20
    -- VirusChangeRotation(myVirus)
    VirusMove(myVirus)
    table.insert(ListVirus, myVirus)
end



-- function VirusChangeRotation(myVirus)
--     local rotation = math.random()
--     if rotation <= 0.3 then
--         myVirus.rotation = 0 - myVirus.rotation
--     end
-- end



function VirusMove(myVirus)
    if math.floor(math.random()) <= 0.3 then
        --if myVirus.Vx == 0 then
            myVirus.Vx = math.random(-10, 10) / 3
        --else
        --    myVirus.Vx = 0 - myVirus.Vx
        --end
    end
    myVirus.Vy = 3
end



function VirusClean()
    ListVirus = {}
    Difficulty = 0
    moveTic = 0
    spawnTic = 0
    Difficulty = 0.1
    AddVirus()
end
