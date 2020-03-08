io.stdout:setvbuf('no')
--love.graphics.setDefaultFilter("nearest")
math.randomseed(os.time())
love.math.setRandomSeed(love.timer.getTime())
local utf8 = require("utf8")
Font1 = love.graphics.newFont("fonts/PixelMaster.ttf", 26)
Font2 = love.graphics.newFont("fonts/PixelMaster.ttf", 70)
Font3 = love.graphics.newFont("fonts/PixelMaster.ttf", 34)
Font4 = love.graphics.newFont("fonts/PixelMaster.ttf", 150)

crop = love.audio.newSource('/songs/crop.mp3', "static")
ouie = love.audio.newSource('/songs/ouie.mp3', "static")

crop:setVolume(0.9)
ouie:setVolume(0.9)

require('title')
require('game')
require('gameover')
require('save')

Scene = "title"

Debug = false

Highscores = {}

local music



function love.load()

    WIDTH = love.graphics.getWidth()
    HEIGHT = love.graphics.getHeight()

    love.window.setTitle("Body Invasion")

    TitleInit()
    GameInit()
    GameoverInit()

    music = love.audio.newSource("/songs/music.mp3", "stream")
    music:setVolume(0.08)
    music:play()
end



function love.update(dt)

    if Scene == "game" then
        GameUpdate(dt)
    elseif Scene == "gameover" then
        GameoverUpdate(dt)
    elseif Scene == "title" then
        TitleUpdate(dt)
    end

    if Scene == "gameover" then
        love.keyboard.setKeyRepeat(true)
    else
        love.keyboard.setKeyRepeat(false)
    end

end



function love.draw()

    if Scene == "game" then
        GameDraw()
    elseif Scene == "gameover" then
        GameoverDraw()
    elseif Scene == "title" then
        TitleDraw()
    end

end



function love.textinput(t)
    if Scene == "gameover" then
        if #Pseudo < 10 then
            Pseudo = Pseudo..t
        end
    end
end



function love.keypressed(key)

    print(key)

    -- QUIT
    if key == 'escape' then
        love.event.quit()
    end

    --
    -- TITLE
    --
    if Scene == "title" then
        -- ->Game
        if key == 'return' then
            GameInit()
            Scene = "game"
        end

    --
    -- GAME
    --
    elseif Scene == "game" then

        -- Debug
        if key == 'p' then
            if Debug then Debug = false
            else Debug = true end
        end

    --
    -- GAMEOVER
    --
    elseif Scene == "gameover" then
        -- ->Title
        if key == 'return' then
            WriteSave(Pseudo, Score)
            TitleGenerate()
            Pseudo = ""
            Scene = "title"
        elseif key == "backspace" then
            local bytoffset = utf8.offset(Pseudo, -1)
            if bytoffset then
                Pseudo = string.sub(Pseudo, 1, bytoffset - 1)
            end
        end
    end

end
