
refreshing = false
highscores = {}

function refresh_leaderboard()
  refreshing = true
  network.async(
  
    function () 
      
      local user = castle.user.getMe()
      my_id   = user.userId
      my_name = user.name or user.username
    
      highscores = castle.storage.getGlobal("highscores") or {}
      
      local old = highscores[my_id]
      if not old or old.p_score < p.score and p.score > 0 then
        highscores[my_id] = {p_name = my_name, p_score = p.score}
      end
      
      castle.storage.setGlobal("highscores", highscores )    
      
      leaderboard = {}
      local copy_h = copy_table(highscores)
      local cn  = 1
      
      for index_p, perf in pairs(highscores) do 
        local maxi = 0
        local index = 0
        for i, p in pairs(copy_h) do
          if maxi < p.p_score then 
            maxi = p.p_score
            index = i
            
            if i == my_id then 
              my_place = cn 
              ox = max( 0 , min(cn - 6, count(highscores) - 19))
            end
          end          
        end
        
        if maxi ~= 0 then
          leaderboard[cn] = index
          copy_h[index] = nil       
          cn = cn + 1
        end
      
      end  
      
      refreshing = false
    end) 
end    