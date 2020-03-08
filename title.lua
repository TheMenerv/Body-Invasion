local title_img = love.graphics.newImage("images/gameover/background.jpg")
local redBlood_img = love.graphics.newImage("images/redblood.png")
local printedScore
local listRedBlood = {}



function TitleInit()
    TitleGenerate()
    for i = 1, 500 do
        GenerateRedBlood()
    end
end



function TitleUpdate(dt)
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



function TitleDraw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(title_img, 0, 0)
    for i = 1, #listRedBlood do
        local blood = listRedBlood[i]
        love.graphics.setColor(1, 1, 1, blood.alpha)
        love.graphics.draw(redBlood_img, blood.x, blood.y, math.rad(blood.angle), blood.scale, blood.scale, redBlood_img:getWidth() / 4, redBlood_img:getWidth() / 4)
        love.graphics.setColor(1, 1, 1, 1)
    end
    love.graphics.setColor(0, 0, 0, 0.65)
    love.graphics.rectangle('fill', 250, 120, 300, 300, 50, 50)
    love.graphics.setFont(Font3)
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print("Press ENTER to play", 285, 370)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(Font3)
    love.graphics.print(printedScore, 300, 150)
end



function TitleGenerate()
    printedScore = "TOP 5"
    local position
    local scores = ReadScore()
    if scores == nil then
        printedScore = printedScore.."\nAucun score !"
    else
        for i = 1, #scores do
            local score = scores[i]
            printedScore = printedScore.."\n"..score.score.." - "..score.name
            i = i + 1
        end
    end
end



function GenerateRedBlood()
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
    table.insert(listRedBlood, blood)
end
