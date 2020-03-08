function WriteSave(pseudo, score)
    -- Si le fichier de sauvegarde n'existe pas
    -- le créé
    if love.filesystem.getInfo('highscores.lst', all) == nil then
        love.filesystem.write('highscores.lst', '', all)
    end

    -- Nettoyage du Hightscores
    for i = 1, #Highscores do
        table.remove(Highscores, i)
        i = i + 1
    end

    -- Parse les scores enregistrés
    local countSave = 0
    for line in love.filesystem.lines('highscores.lst') do
        countSave = countSave + 1
        table.insert(Highscores, line)
    end

    -- Si moins de 5 scores
    -- on enregistre le nouveau score
    if countSave < 1 then
        love.filesystem.write('highscores.lst', pseudo..'|'..score, all)
    elseif countSave < 5 then
        love.filesystem.append('highscores.lst', '\n'..pseudo..'|'..score)
    -- Sinon on cherche le plus petit score enregistré
    else
        local lowestScore = 99999999999999
        local i, j = 0
        for line in love.filesystem.lines('highscores.lst') do
            i = i + 1
            local parsedLine = GetScoreDetail(line)
            local parsedScore = tonumber(parsedLine[2])
            if parsedScore < lowestScore then
                lowestScore = parsedScore
                j = i
            end
        end
        -- Si le nouveau score est meilleur que le moins bon score enregistré
        local oldLowestScore = GetScoreDetail(Highscores[j])
        if tonumber(oldLowestScore[2]) < score then
            -- On le supprime
            table.remove(Highscores, j)
            -- On réécrit le nouveau fichier de score
            i = 1
            local firstLineIsEmpty = false
            for line in love.filesystem.lines('highscores.lst') do
                if i == 1 and i ~= j then
                    love.filesystem.write('highscores.lst', line, all)
                elseif i == 1 and i == j then
                    love.filesystem.write('highscores.lst', '', all)
                    firstLineIsEmpty = true
                else
                    if firstLineIsEmpty then
                        love.filesystem.append('highscores.lst', line)
                        firstLineIsEmpty = false
                    else
                        love.filesystem.append('highscores.lst', '\n'..line)
                    end
                end
                i = i + 1
            end
            love.filesystem.append('highscores.lst', '\n'..pseudo..'|'..score)
        end
    end
end



function ReadScore()
    -- Si pas de meilleur score, retourne rien
    if love.filesystem.getInfo('highscores.lst', all) == nil then
        return
    end

    -- Parse les scores enregistrés
    local scores = {}
    local i = 1
    for line in love.filesystem.lines('highscores.lst') do
        scores[i] = {}
        local detailedScore = GetScoreDetail(line)
        scores[i].name = detailedScore[1]
        scores[i].score = detailedScore[2]
        i = i + 1
    end

    -- Cherche 1er
    local bestScore = {}
    bestScore.score = 0
    bestScore.name = 'unknow'
    for j = 1, #scores do
        if tonumber(scores[j].score) > tonumber(bestScore.score) then
            bestScore.score = scores[j].score
            bestScore.name = scores[j].name
        end
        j = j + 1
    end

    -- Cherche 2ème
    local secondScore = {}
    secondScore.score = 0
    secondScore.name = 'unknow'
    for j = 1, #scores do
        if tonumber(scores[j].score) > tonumber(secondScore.score) and tonumber(scores[j].score) < tonumber(bestScore.score) then
            secondScore.score = scores[j].score
            secondScore.name = scores[j].name
        end
        j = j + 1
    end

    -- Cherche 3ème
    local thirdScore = {}
    thirdScore.score = 0
    thirdScore.name = 'unknow'
    for j = 1, #scores do
        if tonumber(scores[j].score) > tonumber(thirdScore.score) and tonumber(scores[j].score) < tonumber(secondScore.score) then
            thirdScore.score = scores[j].score
            thirdScore.name = scores[j].name
        end
        j = j + 1
    end

    -- Cherche 4ème
    local fourthScore = {}
    fourthScore.score = 0
    fourthScore.name = 'unknow'
    for j = 1, #scores do
        if tonumber(scores[j].score) > tonumber(fourthScore.score) and tonumber(scores[j].score) < tonumber(thirdScore.score) then
            fourthScore.score = scores[j].score
            fourthScore.name = scores[j].name
        end
        j = j + 1
    end

    -- Cherche 5ème
    local fivethScore = {}
    fivethScore.score = 0
    fivethScore.name = 'unknow'
    for j = 1, #scores do
        if tonumber(scores[j].score) > tonumber(fivethScore.score) and tonumber(scores[j].score) < tonumber(fourthScore.score) then
            fivethScore.score = scores[j].score
            fivethScore.name = scores[j].name
        end
        j = j + 1
    end

    return { bestScore, secondScore, thirdScore, fourthScore, fivethScore }
end



function GetScoreDetail(myScore)
    return Split(myScore, '|')
end



function Split(s, delimiter)
    local result = {}
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end
