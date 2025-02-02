io.stdout:setvbuf("no")
LICK = require("dependencies/LICK/lick")
LICK.reset = true

local mainColor = { 99, 140, 109 }
local SecondaryColor = { 231, 251, 180 }
local terciaryColor = { 223, 109, 45 }
local cuartaColor = { 200, 76, 5 }

function ParseColor(color)
    return { color[1] / 255, color[2] / 255, color[3] / 255 }
end

function love.load()
    World = love.physics.newWorld(0, 0, true)

    Ball = {}
    -- https://box2d.org/documentation/group__body.html#ga74ddb02261648c2bff691a866b5c03e0
    Ball.body = love.physics.newBody(World, 400, 200, "dynamic")
    Ball.body:setMass(1)
    Ball.shape = love.physics.newCircleShape(30)
    Ball.fixture = love.physics.newFixture(Ball.body, Ball.shape)
    Ball.fixture:setRestitution(0.4)
    Ball.fixture:setUserData("Ball")

    Ball.body:setLinearDamping(2)
    love.window.setTitle("Project Boxes" .. Ball.body:getX() .. " " .. Ball.body:getY())


    love.graphics.setBackgroundColor(ParseColor(mainColor))
end

function love.update(dt)
    -- Update the physics World with the specified time step (dt)
    World:update(dt)
    local speed = 5000

    if love.keyboard.isDown("right") then
        Ball.body:applyForce(speed, 0)
    end

    if love.keyboard.isDown("left") then
        Ball.body:applyForce(-speed, 0)
    end
    if love.keyboard.isDown("up") then
        Ball.body:applyForce(0, -speed)
    end
    if love.keyboard.isDown("down") then
        Ball.body:applyForce(0, speed)
    end

    love.window.setTitle("Project Boxes " .. math.floor(Ball.body:getLinearVelocity()))
end

function love.draw()
    -- Draw the Ball as a circle using the Ball's position, radius, and line style
    love.graphics.setColor(ParseColor(SecondaryColor))
    love.graphics.circle("fill", Ball.body:getX(), Ball.body:getY(), Ball.shape:getRadius(), 12)


    love.graphics.setColor(ParseColor(cuartaColor))
    love.graphics.polygon('fill', 100, 100, 200, 100, 150, 50)
end
