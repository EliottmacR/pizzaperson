require("game/pp")
require("game/leaderboard")

background_clr = "champi2"

function init_game()
  
  log_str = {}

  init_controls()
  init_fonts()
  init_palette()
  
  load_png("spr_sheet", "game/assets/spr_sheet.png", nil, true) 
  load_png("thankyou", "game/assets/thankyou.png", nil, false) 
  load_png("thankyou2", "game/assets/thankyou2.png", nil, false) 
  load_png("new_highscore", "game/assets/new_highscore.png", nil, false) 
  load_png("retry", "game/assets/retry.png", nil, false) 
  load_png("to_game", "game/assets/to_game.png", nil, false) 
  
  hover_s1 = load_sfx("game/assets/zza1.mp3", nil, 1)
  hover_s2 = load_sfx("game/assets/zza2.mp3", nil, 1)
  hover_s3 = load_sfx("game/assets/zza3.mp3", nil, 1)
  
  
  
  click_s1 = load_sfx("game/assets/pizza.mp3", nil, 1)
  click_s2 = load_sfx("game/assets/pizza2.mp3", nil, 1)
  
  bdc = load_music ("game/assets/big_d_ck.mp3", nil, .1)
  music (bdc, true)
  
  slides = {}
  s_i = 1
  slides[1] = load_png("t0", "game/assets/t0.png", nil, false) 
  slides[2] = load_png("t1", "game/assets/t1.png", nil, false) 
  slides[3] = load_png("t2", "game/assets/t2.png", nil, false) 
  
  spritesheet_grid (16, 16)
  state = "title"
  
  offset = {}
  buttons = {}
  
  local b = {}
  
  b.text = "Yes"
  b.center = {x = GW/2, y = GH/3}
  b.w = str_width(b.text) + 16
  b.h = str_height(b.text) + 16
  add(buttons, b)
  
  b = {}
  
  b.text = "No"
  b.center = {x = GW/2, y = GH/2 + 10}
  b.w = str_width(b.text) + 16
  b.h = str_height(b.text) + 16
  add(buttons, b)
  
  b = {}
  
  b.text = "How can I prove myself ?"
  b.center = {x = GW/2, y = GH/2 + 48*1.5}
  b.w = str_width(b.text) + 16
  b.h = str_height(b.text) + 16
  add(buttons, b)
  
  b = {}
  
  b.text = "Yes, but I don't wanna play"
  b.w = str_width(b.text) + 16
  b.h = str_height(b.text) + 16
  b.center = {x = GW/2, y = GH/2 + 48*3}
  add(buttons, b)
  
  r_b = {}
  
  r_b.text = "Retry"
  r_b.center = {x = GW/3, y = GH*2/3}
  r_b.w = str_width(r_b.text) + 16
  r_b.h = str_height(r_b.text) + 16
  
  q_b = {}
  
  q_b.text = "Title"
  q_b.center = {x = GW*2/3, y = GH*2/3}
  q_b.w = str_width(q_b.text) + 16
  q_b.h = str_height(q_b.text) + 16
  
  b_b = {}
  
  b_b.text = "Title"
  b_b.w = str_width(b_b.text) + 16
  b_b.h = str_height(b_b.text) + 16
  b_b.center = {x = GW - 16 - b_b.w/2 , y = GH - 16 - b_b.h/2 }
  ra_b = {}
  
  ra_b.text = "->"
  ra_b.w = str_width(ra_b.text) + 16
  ra_b.h = str_height(ra_b.text) + 16
  ra_b.center = {x = b_b.center.x - 120 , y = b_b.center.y }
  
  la_b = {}
  
  la_b.text = "<-"
  la_b.w = str_width(la_b.text) + 16
  la_b.h = str_height(la_b.text) + 16
  la_b.center = {x = ra_b.center.x - 45 , y = b_b.center.y }
  
  -- background
  
  num_pizx = ceil((GW - 16)/(_WP * _SF))
  num_pizy = ceil((GH - 16)/(_WP * _SF))
  
  highscore = get_highscores()
  
end

function b_to_r(b) -- button to rect (x, y, w, h)
  return b.center.x - b.w/2, b.center.y - b.h/2, b.w, b.h
end

function update_game()
  
  if state == "title" then
    for i, b in pairs(buttons) do
      local old_h = b.hover
      b.hover = m_in_rect(b_to_r(b))
      if b.hover and b.hover ~= old_h then sfx(hover()) end
      
      if b.hover then
        if btnp("select") then
            timer_end = 2
            sfx(click())
          if i == 1 then -- Yes
            state = "to_game"
          elseif i == 2 then -- No
            state = "thankyou"
          elseif i == 3 then -- tuto
            state = "tutorial"
            s_i = 1
          elseif i == 4 then -- other_quit
            state = "thankyou2"
          end
        end
      end
    end
  elseif state == "to_game" then
    timer_end = timer_end - dt()
    
    if timer_end < 0 then 
      init_pp()
    end
    
  elseif state == "thankyou" or state == "thankyou2" then
    timer_end = (timer_end or 2) - dt()
    
    if timer_end < 0 then require_exit() end
    
  elseif state == "tutorial" then
  
    local b = b_b
    local old_h = b.hover
    b.hover = m_in_rect(b_to_r(b))
    if b.hover and b.hover ~= old_h then sfx(hover()) end
    if b.hover and btnp("select") then
      state = "title"
      sfx(click())
    end
    
    if btnp("left") and s_i > 1 then 
      s_i = s_i - 1
    end
    
    local b = la_b 
    
    local old_h = b.hover
    b.hover = m_in_rect(b_to_r(b))
    if b.hover and b.hover ~= old_h then sfx(hover()) end
    
    if b.hover and btnp("select") and s_i > 1 then 
      s_i = s_i - 1
      
    end
    
    local b = ra_b
    
    local old_h = b.hover
    b.hover = m_in_rect(b_to_r(b))
    if b.hover and b.hover ~= old_h then sfx(hover()) end
    
    if b.hover and btnp("select") and s_i < count(slides) then 
      s_i = s_i + 1
    end
    
  elseif state == "game" then
  
    update_pp() 
    
  elseif state == "new_highscore" or state == "retry" then
    
    local b = r_b -- retry button
    
    local old_h = b.hover
    b.hover = m_in_rect(b_to_r(b))
    if b.hover and b.hover ~= old_h then sfx(hover()) end
    
    if b.hover and btnp("select") then
      timer_end = 2
      sfx(click())
      init_pp()
    end
    
    local b = q_b -- title button
    
    local old_h = b.hover
    b.hover = m_in_rect(b_to_r(b))
    if b.hover and b.hover ~= old_h then sfx(hover()) end
    
    if b.hover and btnp("select") then
      timer_end = 2
      state = "title"
      sfx(click())
    end
    
    for i, h in pairs(highscores) do add_log(i .. " : " .. h.score) end
    
  end
end

function draw_game()
  
  cls(_p_n(background_clr))
  
  if state == "title" then
    draw_background()
    use_font("16")
    wave_print("Are you the Pizza Person ?", GW / 2, 32, _p_n("yellow"), _p_n("black"))
    
    for i, b in pairs(buttons) do
      draw_button(b, i)
    end
    
  elseif state == "thankyou" or state == "thankyou2" then
    x_off = x_off or irnd(30)
    y_off = y_off or irnd(30)
    
    timer = (timer or .2) - dt()
    
    if timer < 0 then x_off = irnd(30) y_off = irnd(30) timer = rnd(.25) end
    
    spr_sheet (state, - x_off, - y_off)
    
  elseif state == "to_game" then
    x_off = x_off or irnd(30)
    y_off = y_off or irnd(30)
    timer = (timer or .2) - dt()
    
    if timer < 0 then x_off = irnd(30) y_off = irnd(30) timer = rnd(.25) end
    
    spr_sheet ("to_game", - x_off, - y_off)
    use_font("32l")
    outlined_print("Highscore : " .. highscore, GW/2 + x_off, GH/2 + y_off, _p_n("red"), _p_n("black"))
    
  elseif state == "tutorial" then
    if slides[s_i] then
      spr_sheet (slides[s_i],0, 0)
    end
    
    draw_button(b_b, 0)
    
    if s_i > 1 then
      draw_button(la_b, i)
    end
    
    if s_i < count(slides) then
      draw_button(ra_b, i)
    end
    
  elseif state == "game" then
    
    draw_pp()
    
  elseif state == "new_highscore" or state == "retry" then
    spr_sheet (state, cos(t()) * 7 - 15, sin(t()) * 7 - 15)
    
    if state == "new_highscore" then
      use_font("32l")
      wave_print("New Highscore : " .. highscore, GW/2, GH/2, _p_n("red"), _p_n("black"), 2)
    end
    
    draw_button(r_b, 1)
    draw_button(q_b, 2)
    
    -- for i = 1, count(highscores)
    
  end
  
  draw_mouse()
  use_font("log")
  print_log()
  
end

function draw_button(b, i)
  local x, y, w, h = b_to_r(b)
  rctf(x, y, w, h, _p_n("black"))
  rctf(x + 5, y + 5, w - 10, h - 10, b.hover and _p_n("green") or _p_n("yellow"))
  use_font("16")
  outlined_print(b.text, b.center.x, b.center.y - cos(t()/2 + .25 * (i or 1)) * 5 - 2, _p_n("red"), _p_n("black"))
end

_WP = 34  -- width pizza
_SF = 1.5 -- scale factor

function draw_background()
  
  local offset_x =  - _WP * _SF +  (t() * _WP * _SF) % _WP * _SF
  local offset_y = 0
  
  for j = 0, num_pizy + 1 do
    for i = 0, num_pizx + 1 do
      a_outlined( 2, _WP * _SF * i + (j%2) * _WP/2 + offset_x, _WP*2 * j + offset_y, t()/2, 2, 2)
    end
  end
  
end

function draw_mouse()
  outlined( 0, btnv("mouse_x") - 8, btnv("mouse_y") - 8)
end

function init_controls()

  register_btn("up",    0, {input_id("keyboard", "z"), input_id("keyboard", "w"), input_id("keyboard", "up")}) 
  register_btn("left",  0, {input_id("keyboard", "q"), input_id("keyboard", "a"), input_id("keyboard", "left")}) 
  register_btn("down",  0, {input_id("keyboard", "s"), input_id("keyboard", "down")})
  register_btn("right", 0, {input_id("keyboard", "d"), input_id("keyboard", "right")})
  
  register_btn("pause", 0,  input_id("keyboard", "space"))  
  register_btn("cheat", 0,  input_id("keyboard", "k"))
  
  register_btn("select", 0,  input_id("mouse_button", "lb"))
  register_btn("back"  , 0,  input_id("mouse_button", "rb"))
  
  register_btn("mouse_x", 0, input_id("mouse_position", "x"))
  register_btn("mouse_y", 0, input_id("mouse_position", "y"))
  
end

function init_fonts()
  
  load_font("game/assets/CC.ttf", 48, "48", false)
  load_font("game/assets/CC.ttf", 32, "32", false)
  load_font("game/assets/CC.ttf", 24, "24", false)
  load_font("game/assets/CC.ttf", 16, "16", true)
  
  load_font("sugarcoat/TeapotPro.ttf", 16, "log", false)
  load_font("sugarcoat/TeapotPro.ttf", 32, "32l", false)
  
end

function any_button()
 if btn("up") or btn("left") or btn("down") or btn("right") then return true end 
end


function hover()
  local s = irnd(3)
  if s == 0 then return hover_s1
  elseif s == 1 then return hover_s2
  else return hover_s3
  end
end

function click()
  local s = irnd(2)
  if s == 0 then return click_s1
  else return click_s2
  end
end


