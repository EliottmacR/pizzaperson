
refreshing = false
highscores = {}

function get_highscores()
  if not refreshing then
    refresh_highscores()
  end
  highscores = get_ordered_tab(nil, highscores, score)
end

function refresh_highscores(score)
  refreshing = true
  network.async(
  
    function (score) 
      
      local user = castle.user.getMe()
      my_id   = user.userId
      my_name = user.name or user.username
    
      highscores = castle.storage.getGlobal("highscores") or {}
      local score = score or 0
      
      local old = highscores[my_id]
      if not old or old.p_score < p.score and p.score > 0 then
        highscores[my_id] = {p_name = my_name, p_score = p.score}
      end
      
      castle.storage.setGlobal("highscores", highscores )
      
      refreshing = false
    end) 
end    