function love.load()
    love.window.setTitle("Nice Game")
    love.window.setMode(800, 600)
    love.mouse.setVisible(false)

    screenWidth = love.graphics.getWidth()
    screenHeight = love.graphics.getHeight()
    
    gameFont = love.graphics.newFont(20)
    
    score = 0
    timer = 10
    gameState = 1

    target = {}
    target.radius = 50
    target.x = math.random(target.radius + 20, screenWidth - target.radius)
    target.y = math.random(target.radius + 20, screenHeight - target.radius)
    
    sprites = {}
    sprites.sky = love.graphics.newImage('Sprites/sky.png')
    sprites.target = love.graphics.newImage('Sprites/target.png')
    sprites.crosshairs = love.graphics.newImage('Sprites/crosshairs.png')
end
------------------------------------------------------------------------------------
function love.update(dt)
    if gameState == 2 then   
        if timer > 0 then
            timer = timer -dt
        end

        if timer < 0 then 
            timer = 0
            gameState = 1
        end
    end
end
------------------------------------------------------------------------------------
function love.draw()
    love.graphics.draw(sprites.sky, 0, 0)

    if gameState == 1 then
        love.graphics.printf("Right click to play!", 0, 250, screenWidth, "center")
        love.graphics.printf("Your score is: " .. score, 0, 300, screenWidth, "center")
    end

    if gameState == 2 then
        love.graphics.setColor(1, 1, 1)
        love.graphics.setFont(gameFont)
        love.graphics.print("Score:", screenWidth / 2, 0)
        love.graphics.print("Time:", 10, 0)
        love.graphics.print(score, screenWidth / 2, 20)
        love.graphics.print(math.ceil(timer), 10, 20)
    end

    if gameState == 2 then
        love.graphics.draw(sprites.target, target.x - 50, target.y - 50)
        love.graphics.draw(sprites.crosshairs, love.mouse.getX() - 20, love.mouse.getY() - 20)
    end
end
------------------------------------------------------------------------------------
function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 and gameState == 2 then
        local mouseToTarget = distanceBetween(x, y, target.x, target.y)
        if mouseToTarget < target.radius then
            score = score + 1
            target.x = math.random(target.radius + 20, screenWidth - target.radius)
            target.y = math.random(target.radius + 20, screenHeight - target.radius)
        else
            love.graphics.printf("Missed!: ", 0, 300, screenWidth, "center")
            if score > 0 then
                score = score - 1
            end
        end
    end

    if button == 2 and gameState == 2 then
        local mouseToTarget = distanceBetween(x, y, target.x, target.y)
        if mouseToTarget < target.radius then
            score = score + 2
            timer = timer - 1
            target.x = math.random(target.radius + 20, screenWidth - target.radius)
            target.y = math.random(target.radius + 20, screenHeight - target.radius)
        end
    end
    
    if gameState == 1 and button == 2 then
        gameState = 2
        timer = 10
        score = 0
    end
end
------------------------------------------------------------------------------------
function distanceBetween(x1, y1, x2, y2)
    return math.sqrt( (x2 - x1)^2 + (y2 - y1)^2 )
end
------------------------------------------------------------------------------------