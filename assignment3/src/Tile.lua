--[[
    GD50
    Match-3 Remake

    -- Tile Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The individual tiles that make up our game board. Each Tile can have a
    color and a variety, with the varietes adding extra points to the matches.
]]

Tile = Class{}

function Tile:init(x, y, color, variety, isShiny)
    
    -- board positions
    self.gridX = x
    self.gridY = y

    -- coordinate positions
    self.x = (self.gridX - 1) * 32
    self.y = (self.gridY - 1) * 32

    -- tile appearance/points
    self.color = color
    self.variety = variety

    self.isShiny = randomShiny(math.random(30))

    self.psystem = love.graphics.newParticleSystem(gTextures['particle'], 32)
    self.psystem:setParticleLifetime(0.5, 1.0)
    self.psystem:setLinearAcceleration(-5, -5, 5, 5)
    self.psystem:setEmissionArea('borderrectangle', 13, 13)
end

function Tile:update(dt)
    self.psystem:update(dt)
    
end

function Tile:render(x, y)
    
    -- draw shadow
    love.graphics.setColor(0.13, 0.13, 0.2, 1.0)
    love.graphics.draw(gTextures['main'], gFrames['tiles'][self.color][self.variety],
        self.x + x + 2, self.y + y + 2)
    -- print_r (gFrames)            -- print table of gFrames in debug console
    -- draw tile itself
    love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
    love.graphics.draw(gTextures['main'], gFrames['tiles'][self.color][self.variety],
        self.x + x, self.y + y)
end

function Tile:renderParticles()
    love.graphics.draw(self.psystem, self.x + 256, self.y + 32)
end

function Tile:emitParticles()
    self.psystem:setColors(
        0.8, 0.8, 0.8, 0.4,
        0.5, 0.5, 0.5, 0.0
    )

    self.psystem:emit(32)
end

function randomShiny(value)
    if value < 3 then
        return true
    else
        return false
    end
end