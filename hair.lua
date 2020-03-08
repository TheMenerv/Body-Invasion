function HairInit()
    BuildHair()                                                                 -- appel construction poil
    HairCurve={}                                                                -- table pour stocker les coordonnees des poils
    move=0                                                                      -- mouvement du poil
    sens=-1                                                                     -- sens du mouvement
  end
  
  function HairUpdate(dt)
    move=move+dt*sens
    if move>1.25 then
      move=1.25
      sens=-sens
    end
    if move<-1.25 then
      move=-1.25
      sens=-sens
    end        -- calcul du mouvement
    for n,hair in ipairs(HairsPoints) do                                         -- pour chaque poil on change la coordonnee d'arrivee du poil
      hair[5]=hair[5]+move
      HairCurve[n]=  love.math.newBezierCurve(hair)                               -- on genere la courbe de bézier, et on la stock dans une table
    end
  end
  
  function HairDraw()
    love.graphics.setColor(41/255, 20/255, 0)
    love.graphics.setLineWidth(15)                                                   -- taille en largeur du poil
    for v,hair in ipairs(HairCurve) do
      love.graphics.line(hair:render())                                              -- on dessine chaque poil stocké dans la table
    end
    love.graphics.setColor(1, 1, 1)
  end
  
  function BuildHair()
    HairsPoints={}                                                                    -- table pour stocker les coordonnees des poils
    for n=1,20 do                                                                      -- nombre de poils
        local x1,y1,x2,y2=math.random(800),294,math.random(-100,100),-10           -- coordonnées de chaque poil, x,y départ, x,y milieu endroit de la courbure
        table.insert(HairsPoints,{x1,y1,x1,y1/2,x1+x2,y2})                            -- x,y final, arrivée du poil
    end
  
  end
  