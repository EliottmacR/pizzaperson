
function wait_before_next_d2()
  score = score + (col_LEFT == right and 1 or 0) 
                + (col_RIGHT == right and 1 or 0)
  if col_LEFT ~= right or col_RIGHT ~= right then
    hp = hp - 1
    wait_before_next = 1
  end
end


function draw_play_area_d2()
  if LEFT then
    rctf(0, 0, w_pa/2, h_pa, _p_n(waiting_col))
  end
  
  if RIGHT then
    rctf(w_pa/2, 0, w_pa/2, h_pa, _p_n(waiting_col))
  end
  
  if timer < -.2 then
  
    -- LEFT
    local found_LEFT = (words[1] == "Pizza" or words[1] == "pizza")
    
    col_LEFT = 
        (not LEFT and found_LEFT and shouldhave) 
    or  (not LEFT and not found_LEFT and right)
    or  (LEFT and found_LEFT and right)
    or  (LEFT and not found_LEFT and wrong)
    
    rctf(0, 0, w_pa/2, h_pa, _p_n(col_LEFT))
    ----------------
    
    -- RIGHT
    local found_RIGHT = (words[2] == "Pizza" or words[2] == "pizza")
    
    col_RIGHT = 
        (not RIGHT and found_RIGHT and shouldhave) 
    or  (not RIGHT and not found_RIGHT and right)
    or  (RIGHT and found_RIGHT and right)
    or  (RIGHT and not found_RIGHT and wrong)
    
    rctf(w_pa/2, 0, w_pa/2, h_pa, _p_n(col_RIGHT))
    ----------------
    
  end
  
  if words[1] then
    outlined_print(words[1], w_pa/4, h_pa/2)
  end
  
  if words[2] then
    outlined_print(words[2], w_pa*3/4, h_pa/2)
  end

  a_outlined(4, 12, h_pa/2, .75)
  a_outlined(4, w_pa - 12, h_pa/2, .25)
      
end

