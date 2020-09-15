--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    bronzeScore = 2
    silverScore = 4
    goldScore = 6
    scoreString = 'Oof! You lost!'
    imagePath = 'bird.png'

    if self.score >= goldScore then
        scoreString = 'You got a gold medal!'
        imagePath = 'medal_gold.png'
    elseif self.score >= silverScore then
        scoreString = 'You got a silver medal!'
        imagePath = 'medal_silver.png'
    elseif self.score >= bronzeScore then
        scoreString = 'You got a bronze medal!'
        imagePath = 'medal_bronze.png'
    end

    -- draw the medal in the center of the screen
    medalImage = love.graphics.newImage(imagePath)
    imageWidth = medalImage:getWidth()
    imageHeight = medalImage:getHeight()
    love.graphics.draw(medalImage, (VIRTUAL_WIDTH / 2) - (imageWidth / 2), 180)

    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf(scoreString, 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
end