Player = {}
Player.img = love.graphics.newImage('images/game/whiteblood.png')
Player.speed = 6
MAXPLAYERSCALE = 0.4
MINPLAYERSCALE = 0.2



function PlayerInit()
    PlayerClean()
end



function PlayerUpdate(dt)
    -- Déplacement du joueur
    if love.keyboard.isDown('up') then
        Player.Y = Player.Y - Player.speed
    end
    if love.keyboard.isDown('right') then
        Player.X = Player.X + Player.speed
    end
    if love.keyboard.isDown('down') then
        Player.Y = Player.Y + Player.speed
    end
    if love.keyboard.isDown('left') then
        Player.X = Player.X - Player.speed
    end

    -- Collision du joueur avec la peau et la veine
    if Player.Y < SKINPOSITION + ((Player.img:getHeight() / 2) * PLAYERSCALE) then
        Player.Y = SKINPOSITION + ((Player.img:getHeight() / 2) * PLAYERSCALE)
    elseif Player.Y > HEIGHT - ((Player.img:getHeight() / 2) * PLAYERSCALE) - VEINEPOSITION then
        Player.Y = HEIGHT - ((Player.img:getHeight() / 2) * PLAYERSCALE) - VEINEPOSITION
    end
    -- Collision du joueur avec les bords
    if Player.X < ((Player.img:getWidth() / 2) * PLAYERSCALE) then
        Player.X = ((Player.img:getWidth() / 2) * PLAYERSCALE)
    elseif Player.X > WIDTH - ((Player.img:getWidth() / 2) * PLAYERSCALE) then
        Player.X = WIDTH - ((Player.img:getWidth() / 2) * PLAYERSCALE)
    end
end



function PlayerDraw()
    love.graphics.draw(Player.img, Player.X, Player.Y, 0, PLAYERSCALE ,PLAYERSCALE, Player.img:getWidth() / 2, Player.img:getHeight() / 2)
end



function IsInPlayer(x, y)
    return
        (x >= Player.X - (((Player.img:getWidth() - (Player.img:getWidth() / 4))) * PLAYERSCALE)) and
        (x <= Player.X + (((Player.img:getWidth() - (Player.img:getWidth() / 4))) * PLAYERSCALE)) and
        (y >= Player.Y - (((Player.img:getHeight() - (Player.img:getHeight() / 4))) * PLAYERSCALE)) and
        (y <= Player.Y + (((Player.img:getHeight() - (Player.img:getHeight() / 4))) * PLAYERSCALE))
end



function PlayerClean()
    PLAYERSCALE = MAXPLAYERSCALE
    
    -- Position initiale du Player
    Player.X = WIDTH / 2
    Player.Y = (HEIGHT / 4) * 3
    Player.Vx = 0
    Player.Vy = 0
end
