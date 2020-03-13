
refreshing = false
highscores = {}
refreshed = false

function refresh_highscores()

  refreshing = true
  
  network.async(
  
    function () 
      
      local user = castle.user.getMe()
      my_id   = user.userId
      my_name = user.name or user.username
    
      -- highscores = castle.storage.getGlobal("highscores") or {}
      highscores = {}
      
      for i = 1, 100 do 
        highscores[i] = { name = "Bot" .. i , score = 4 + irnd(4)}
      end
      
      -- leaderboard
      
      if count(highscores) > 0 then
        leaderboard = get_ordered_tab(nil, highscores, "score")
      end
      
      highscore = highscores[my_id] and highscores[my_id].score or 0
      -- variable = highscores[my_id].score
      
      refreshing = false
    end) 
end

function update_score()

  local user = castle.user.getMe()
  my_id   = user.userId
  my_name = user.name or user.username
  
  old = highscores[my_id]
  old_highscore = old and highscores[my_id].score or 0
  
  if not old or old.score < score then
    highscores[my_id] = {name = my_name, score = score}
  end
  
  highscore = highscores[my_id] and highscores[my_id].score or 0
  
  if count(highscores) > 0 then
    leaderboard = get_ordered_tab(nil, highscores, "score")
  end
  
  network.async(function ()
    castle.storage.setGlobal("highscores", highscores )
  end)

end

function draw_highscores()
  
  if not leaderboard or count(leaderboard) == 0 then return end
  
  use_font("32l")
  
  local mw_index = 0
  local mw_score = 0
  local mw_name = 0
  
  local mw = 0
  
  for i = 1, count(leaderboard) do 
    local h = leaderboard[i]
    if h and h.name and h.score then
      mw_index = max(mw_index, str_width(s(i_to_s(i))))
      mw_score = max(mw_score, str_width(s(h.score)))
      mw_name  = max(mw_name , str_width(s(h.name)))
    end
  end
  
  -- mw = mw_index + mw_score + mw_name
  mw = mw_index + str_width("Scr")/2
  -- mw = 0
  
  
  -- local t_x, t_y = GW/2 - mw/2, 25
  local t_x, t_y = GW/2 - mw, 50
    
    outlined_print("Rnk"  , t_x, t_y)
    outlined_print("Scr"  , t_x + mw_index, t_y)
    outlined_print("Name" , t_x + mw_index + mw_score + mw_name/2 , t_y)

  
  for i = 1, min(8, count(leaderboard)) do 
    local h = leaderboard[i]
    if h then
      local name = h.name
      local score = h.score
      if score and name then
        
        local x, y = t_x, t_y + 5 + str_height("I") * (i)
        local place = i
        
        if i == 8 then
          local rk = get_my_rank()
          if rk > 8 then
            place = rk
            h = leaderboard[place]
            name = h.name
            score = h.score
          end
        
        end
        
        local col = (i == 1 and _p_n("bread") or (name == my_name) and _p_n("blue") or _p_n("black"))
        
        outlined_print(s(i_to_s(place)), x, y, col)
        outlined_print(score, x + mw_index, y, col)
        outlined_print(name , x + mw_index + mw_score + mw_name/2 , y, col)
        
      end
    end
  end
end

function get_my_rank()
  -- variable = i
  for i = 1, count(leaderboard) do 
    if leaderboard[i].name == my_name then 
      return i 
    end 
  end 
end

function s(str) return " " .. str .. " " end

function i_to_s(i) return i .. get_s(i) end

function get_s(n)
  n = n % 100
  if n < 10 or n > 20 then
    n = n % 10
    if n == 1 then return "st" end 
    if n == 2 then return "nd" end 
    if n == 3 then return "rd" end 
  end
  return "th"
end






