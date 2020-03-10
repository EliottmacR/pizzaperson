
function wait_before_next_d4()
  score = score + (col_LEFT == right and 1 or 0) 
                + (col_RIGHT == right and 1 or 0)
                + (col_UP == right and 1 or 0)
                + (col_DOWN == right and 1 or 0)
  if col_LEFT ~= right or col_RIGHT ~= right or col_UP ~= right or col_DOWN ~= right then
    hp = hp - 1
    wait_before_next = 1
  end
end


function draw_play_area_d4()
  if LEFT then
    draw_back_left_d4(_p_n(waiting_col))
  end
  
  if RIGHT then
    draw_back_right_d4(_p_n(waiting_col))
  end
  
  if UP then
    draw_back_up_d4(_p_n(waiting_col))
  end
  
  if DOWN then
    draw_back_down_d4(_p_n(waiting_col))
  end
  
  if timer < -.2 then
  
    -- LEFT
    local found_LEFT = (words[1] == "Pizza" or words[1] == "pizza")
    
    col_LEFT = 
        (not LEFT and found_LEFT and shouldhave) 
    or  (not LEFT and not found_LEFT and right)
    or  (LEFT and found_LEFT and right)
    or  (LEFT and not found_LEFT and wrong)
    draw_back_left_d4(_p_n(col_LEFT))
    ----------------
    
    -- RIGHT
    local found_RIGHT = (words[2] == "Pizza" or words[2] == "pizza")
    
    col_RIGHT = 
        (not RIGHT and found_RIGHT and shouldhave) 
    or  (not RIGHT and not found_RIGHT and right)
    or  (RIGHT and found_RIGHT and right)
    or  (RIGHT and not found_RIGHT and wrong)
    
    draw_back_right_d4(_p_n(col_RIGHT))
    ----------------
    
    -- UP
    local found_UP = (words[3] == "Pizza" or words[3] == "pizza")
    
    col_UP = 
        (not UP and found_UP and shouldhave) 
    or  (not UP and not found_UP and right)
    or  (UP and found_UP and right)
    or  (UP and not found_UP and wrong)
    
    draw_back_up_d4(_p_n(col_UP))
    ----------------
    
    -- DOWN
    local found_DOWN = (words[4] == "Pizza" or words[4] == "pizza")
    
    col_DOWN = 
        (not DOWN and found_DOWN and shouldhave) 
    or  (not DOWN and not found_DOWN and right)
    or  (DOWN and found_DOWN and right)
    or  (DOWN and not found_DOWN and wrong)
    
    draw_back_down_d4(_p_n(col_DOWN))
    ----------------
    
  end
  
  if words[1] then
    a_outlined(4, 12, h_pa/2, .75)
    outlined_print(words[1], w_pa/4, h_pa/2)
  end
  
  if words[2] then
    a_outlined(4, w_pa - 12, h_pa/2, .25)
    outlined_print(words[2], w_pa*3/4, h_pa/2)
  end
  
  if words[3] then
    a_outlined(4, w_pa/2, 12)
    outlined_print(words[3], w_pa/2, h_pa/4)
  end
  
  if words[4] then
    a_outlined(4, w_pa/2, h_pa - 12, .5)
    outlined_print(words[4], w_pa/2, h_pa*3/4)
  end

end

function draw_back_left_d4(col)
  trifill(A[1], A[2], F[1], F[2], I[1], I[2], col)
end

function draw_back_right_d4(col)
  trifill(B[1], B[2], E[1], E[2], I[1], I[2], col)
end

function draw_back_up_d4(col)
  trifill(A[1], A[2], B[1], B[2], I[1], I[2], col)
end

function draw_back_down_d4(col)
  trifill(E[1], E[2], F[1], F[2], I[1], I[2], col)
end
