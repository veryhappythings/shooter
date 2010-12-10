Entity = {}
Entity.__index = Entity

function Entity.create(x, y)
    local temp = {}
    setmetatable(temp, Entity)
    temp.x = x
    temp.y = y
    return temp
end
function Entity:draw()
    love.graphics.draw(enemy_img, self.x, self.y)
end

-- -------------------------------------

function love.load()
    player_img = love.graphics.newImage("player.jpg")
    enemy_img = love.graphics.newImage("enemy.jpg")
    bullet_img = love.graphics.newImage("bullet.jpg")

    player_x = 5
    player_y = 100

    player_speed = 50
    bullet_speed = 100

    window_width = 800

    bullets = {}
    waves = {}

    create_wave()
end

function love.draw()
    love.graphics.draw(player_img, player_x, player_y)

    for n, bullet in pairs(bullets) do
        love.graphics.draw(bullet_img, bullet[1], bullet[2])
    end

    for n, wave in pairs(waves) do
        for n, enemy in pairs(wave) do
            enemy:draw()
        end
    end

    -- debug
    love.graphics.print(#bullets, 10, 10)
    love.graphics.print(#waves, 30, 10)
end

function love.update(dt)
    -- keys
    if love.keyboard.isDown("up") then
        player_y = player_y - player_speed * dt
    end
    if love.keyboard.isDown("down") then
        player_y = player_y + player_speed * dt
    end
    if love.keyboard.isDown("left") then
        player_x = player_x - player_speed * dt
    end
    if love.keyboard.isDown("right") then
        player_x = player_x + player_speed * dt
    end

    -- tick
    for n, bullet in pairs(bullets) do
        bullet[1] = bullet[1] + (bullet_speed * dt)
        if bullet[1] > window_width then
            table.remove(bullets, n)
        end
    end

    for n, wave in pairs(waves) do
        for n, enemy in pairs(wave) do
            enemy.x = enemy.x - (player_speed * dt)
            if enemy.x < 0 then
                table.remove(wave, n)
            end
        end
        if #wave <= 0 then
            table.remove(waves, n)
        end
    end
end

function love.keypressed(key, unicode)
    if key == ' ' then
        bullet_coords = {player_x+15, player_y+10}
        table.insert(bullets, bullet_coords)
    end
end

function create_wave()
    wave = {}
    for i=1, 5 do
        enemy = Entity.create(window_width, i*20)
        table.insert(wave, enemy)
    end
    table.insert(waves, wave)
end

