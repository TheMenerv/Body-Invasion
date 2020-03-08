require('blood')
require('player')
require('virus')
require('hair')

local bg = love.graphics.newImage('images/game/skin.jpg')

SKINPOSITION = 305
VEINEPOSITION = 35



function GameInit()

    NewGame()

    PlayerInit()
    BloodInit()
    VirusInit()
    HairInit()
end



function GameUpdate(dt)
    Score = math.floor(Difficulty * 100)

    PlayerUpdate(dt)
    VirusUpdate(dt)
    BloodUpdate(dt)
    HairUpdate(dt)
end



function GameDraw()
    love.graphics.draw(bg, 0, 0, 0, 1 ,1)
    HairDraw()

    BloodDraw()
    VirusDraw()
    PlayerDraw()

    -- Score
    love.graphics.setColor(1, 0, 0)
    love.graphics.setFont(Font1)
    love.graphics.print("Score: "..tostring(Score), 2, -5)
    love.graphics.print("Health: "..tostring(Health), 2, 10)
    if Debug then
        love.graphics.print("Virus: "..tostring(#ListVirus).." Blood: "..tostring(#ListBlood)..
            " Difficulty: "..tostring(math.floor(Difficulty * 100)).."%", 250, -5)
    end
    love.graphics.setColor(1, 1, 1)
end



function NewGame()
    Health = 100
    Score = 0
    VirusClean()
    BloodClean()
    PlayerClean()
end
