BULLET_MOVEMENT_SPEED = 5
PLAYER_MOVEMENT_SPEED = 10
MOVEMENT_SPEED = 1

Shoes.app :height => 300, :width => 600, :resizable => false do
  def new_wave
    wave = []
    (0..5).each do |i|
      if rand(2) > 0
        wave << image('enemy.jpg', :top => i*50, :left => 600, :height => 30)
      end
    end
    return wave
  end
  
  def new_bullet(source)
    return rect(:top => source.top + 15, :left => source.left + source.full_width, :height => 4, :width => 4)
  end

  def collide? (shape1, shape2)
    if shape1.top + shape1.style[:height] < shape2.top ||
       shape1.top > shape2.top + shape2.style[:height] ||
       shape1.left + shape1.width < shape2.left ||
       shape1.left > shape2.left + shape2.width
      return false
    end
    return true
  end
  
  background black
  fill white
  (0..200).each do |i|
    rect :left => rand(600), :top => rand(300), :width => rand(3)+1
  end
  
  player = image 'player.jpg', :top => 100, :left => 5, :height => 30
  waves = [new_wave]
  bullets = []
  
  ###############################
  
  keypress do |k|
    case k
      when 'w' then
        player.top = player.top - PLAYER_MOVEMENT_SPEED
      when 's' then
        player.top = player.top + PLAYER_MOVEMENT_SPEED
      when 'a' then
        player.left = player.left - PLAYER_MOVEMENT_SPEED
      when 'd' then
        player.left = player.left + PLAYER_MOVEMENT_SPEED
      when ' ' then
        bullets << new_bullet(player)
    end
  end

  animate(50) do |i|
    waves.each do |wave|
      wave.each do |enemy|
        enemy.left = enemy.left - MOVEMENT_SPEED
        if collide? player, enemy
          exit
        end
        bullets.each do |bullet|
          if collide? enemy, bullet
            wave.delete enemy
            enemy.hide
            bullets.delete bullet
            bullet.hide
          end
        end
      end

      if wave.length == 0 || wave[0].left == -30
        wave.each do |enemy|
          enemy.hide
        end
        waves.delete wave
      end
    end

    bullets.each do |bullet|
      bullet.left = bullet.left + BULLET_MOVEMENT_SPEED
      if bullet.left > 600
        bullets.delete bullet
        bullet.hide
      end
    end
  end

  every(4) do
    waves << new_wave
  end
end
