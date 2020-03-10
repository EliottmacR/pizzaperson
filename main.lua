require("game/game")  -- where all the fun happens
require("game/palette")
require("game/random_functions")

require("sugarcoat/sugarcoat")
sugar.utility.using_package(sugar.S, true)


zoom = 2
GH = 700 / zoom
GW = GH * 4/3

function love.load()
  init_sugar("? Are you the pizza person ?", GW, GH, zoom )
  -- screen_render_integer_scale(false)
  -- use_palette(palettes.bubblegum16)

  set_frame_waiting(30)
  
  love.math.setRandomSeed(os.time())
  -- love.mouse.setVisible(true)
  
  init_game()
end

function love.update(dt)
  update_game(dt)
end


function love.draw()
  draw_game()
end















