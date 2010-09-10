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
end

function love.draw()
    love.graphics.draw(player_img, player_x, player_y)
    for i=1, #bullets do
        if bullets[i] then
            love.graphics.draw(bullet_img, bullets[i][1], bullets[i][2])
        end
    end

    -- debug
    love.graphics.print(#bullets, 10, 10)
end

function love.update(dt)
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

    for i=1, #bullets do
        if bullets[i] then
            bullets[i][1] = bullets[i][1] + bullet_speed * dt
            if bullets[i][1] > window_width then
                table.remove(bullets, i)
            end
        end
    end
end

function love.keypressed(key, unicode)
    if key == ' ' then
        bullet_coords = {player_x+15, player_y+10}
        table.insert(bullets, bullet_coords)
    end
end

