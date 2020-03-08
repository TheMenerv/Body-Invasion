local gameover_img = love.graphics.newImage("images/gameover/background.jpg")
local redBlood_img = love.graphics.newImage("images/yellowblood.png")
local virus_img = love.graphics.newImage("images/virus.png")
local listRedBlood = {}


function GameoverInit()
    GamoverClean()
    for i = 1, 300 do
        GenerateRedBlood2()
    end
end



function GameoverUpdate(dt)
    for i = 1, #listRedBlood do
        local blood = listRedBlood[i]
        blood.x = blood.x + blood.vX
        blood.y = blood.y + blood.vY
        if blood.x < 0 - (WIDTH / 4) or blood.x > WIDTH + (WIDTH / 4) then
            blood.vX = 0 - blood.vX
        end
        if blood.y < 0 - (HEIGHT / 3) or blood.y > HEIGHT + (HEIGHT / 3) then
            blood.vY = 0 - blood.vY
        end
        blood.angle = (blood.angle + blood.vAngle) % 360
    end
end



function GameoverDraw()
    love.graphics.draw(gameover_img, 0, 0, 0, 1 ,1)
    for i = 1, #listRedBlood do
        local blood = listRedBlood[i]
        love.graphics.setColor(1, 1, 1, blood.alpha)
        if blood.type == 1 then
            love.graphics.draw(redBlood_img, blood.x, blood.y, math.rad(blood.angle), blood.scale, blood.scale, redBlood_img:getWidth() / 4, redBlood_img:getWidth() / 4)
        else
            love.graphics.draw(virus_img, blood.x, blood.y, math.rad(blood.angle), blood.scale * 1.5, blood.scale * 1.5, redBlood_img:getWidth() / 4, redBlood_img:getWidth() / 4)
        end
    end
    love.graphics.setColor(1, 1, 1, 0.65)
    love.graphics.rectangle('fill', 100, 390, 590, 120, 30, 30)
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(Font2)
    love.graphics.print("Pseudo:", 165, 385)
    love.graphics.print(Pseudo, 370, 385)
    love.graphics.setColor(0, 0, 1, 1)
    love.graphics.print("Press ENTER to continue", 120, 440)
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(Font4)
    love.graphics.print("GAME OVER", 150, 200)
end



function GamoverClean()
    Pseudo = ""
end



function GenerateRedBlood2()
    local blood = {}
    local r = redBlood_img:getWidth() / 2
    blood.x = love.math.random(0 - (r * 2), WIDTH + (r * 2))
    blood.y = love.math.random(0 - (r * 2), HEIGHT + (r * 2))
    blood.vX = (love.math.random(20) - 10) / 10
    blood.vY = (love.math.random(20) - 10) / 10
    blood.angle = math.random(360)
    blood.vAngle = (love.math.random(20) - 10) / 10
    blood.scale = math.random(10) / 50
    blood.alpha = math.random(50, 100) / 100
    blood.type = math.random(2)
    table.insert(listRedBlood, blood)
end
