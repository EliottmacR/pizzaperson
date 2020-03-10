

function wait_before_next_d1()
  score = score + (col_UP == right and 1 or 0)
  if col_UP ~= right then
    hp = hp - 1
    wait_before_next = 1
  end
end

function draw_play_area_d1()
    
  if UP then
    rctf(0, 0, w_pa, h_pa, _p_n(waiting_col))
  end
  
  if timer < -.2 then
  
    local found_UP = (words[1] == "Pizza" or words[1] == "pizza")
    
    col_UP = 
        (not UP and found_UP and shouldhave) 
    or  (not UP and not found_UP and right)
    or  (UP and found_UP and right)
    or  (UP and not found_UP and wrong)
    
    rctf(0, 0, w_pa, h_pa, _p_n(col_UP))
    
  end
  if words[1] then
    outlined_print(words[1], w_pa/2 + offset[1].x - 8, h_pa/2 + offset[1].y - 8)
  end
  
  a_outlined(4, w_pa/2, 12)
      
end
