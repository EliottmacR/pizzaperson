
function wait_before_next_d3()
  score = score + (col_LEFT == right and 1 or 0) 
                + (col_RIGHT == right and 1 or 0)
                + (col_UP == right and 1 or 0)
  if col_LEFT ~= right or col_RIGHT ~= right or col_UP ~= right then
    hp = hp - 1
    wait_before_next = 1
  end
end


function draw_play_area_d3()
  if LEFT then
    draw_back_left_d3(_p_n(waiting_col))
  end
  
  if RIGHT then
    draw_back_right_d3(_p_n(waiting_col))
  end
  
  if UP then
    draw_back_up_d3(_p_n(waiting_col))
  end
  
  if timer < -.2 then
  
    -- LEFT
    local found_LEFT = (words[1] == "Pizza" or words[1] == "pizza")
    
    col_LEFT = 
        (not LEFT and found_LEFT and shouldhave) 
    or  (not LEFT and not found_LEFT and right)
    or  (LEFT and found_LEFT and right)
    or  (LEFT and not found_LEFT and wrong)
    draw_back_left_d3(_p_n(col_LEFT))
    ----------------
    
    -- RIGHT
    local found_RIGHT = (words[2] == "Pizza" or words[2] == "pizza")
    
    col_RIGHT = 
        (not RIGHT and found_RIGHT and shouldhave) 
    or  (not RIGHT and not found_RIGHT and right)
    or  (RIGHT and found_RIGHT and right)
    or  (RIGHT and not found_RIGHT and wrong)
    
    draw_back_right_d3(_p_n(col_RIGHT))
    ----------------
    
    -- UP
    local found_UP = (words[3] == "Pizza" or words[3] == "pizza")
    
    col_UP = 
        (not UP and found_UP and shouldhave) 
    or  (not UP and not found_UP and right)
    or  (UP and found_UP and right)
    or  (UP and not found_UP and wrong)
    
    draw_back_up_d3(_p_n(col_UP))
    ----------------
    
  end
  
  if words[1] then
    a_outlined(4, 12, h_pa*3/5, .75)
    outlined_print(words[1], w_pa*2/9, h_pa*3/5)
  end
  
  if words[2] then
    a_outlined(4, w_pa - 12, h_pa*3/5, .25)
    outlined_print(words[2], w_pa*7/9, h_pa*3/5)
  end
  
  if words[3] then
    a_outlined(4, w_pa/2, 12)
    outlined_print(words[3], w_pa/2, h_pa/3)
  end

end

function init_points(col)
  A = {0,0}
  B = {w_pa,0}
  C = {w_pa,h_pa/10}
  D = {0,h_pa/10}

  E = {w_pa,h_pa} 
  F = {0,h_pa} 
  G = {w_pa/2,h_pa*2/3} 
  H = {w_pa/2,h_pa} 
  
  I = {w_pa/2,h_pa/2} 
end

function draw_back_left_d3(col)
  trifill(D[1], D[2], G[1], G[2], H[1], H[2], col)
  trifill(D[1], D[2], H[1], H[2], F[1], F[2], col)
end

function draw_back_right_d3(col)
  trifill(C[1], C[2], G[1], G[2], H[1], H[2], col)
  trifill(C[1], C[2], H[1], H[2], E[1], E[2], col)
end

function draw_back_up_d3(col)
  rectfill(A[1], A[2], C[1], C[2], col)
  trifill(D[1], D[2], G[1], G[2], C[1], C[2], col)
end
