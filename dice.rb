p1_total = 0
p2_total = 0
draw_total = 0

while true do
    player_1_dice_1 = rand(1..6)
    player_1_dice_2 = rand(1..6)
    
    player_2_dice_1 = rand(1..6)
    player_2_dice_2 = rand(1..6)
    
    player_1_Score = player_1_dice_1 + player_1_dice_2
    player_2_Score = player_2_dice_1 + player_2_dice_2
    
    puts("Player One score: #{player_1_dice_1} & #{player_1_dice_2}, in total: #{player_1_Score}")
    puts("Player Two score: #{player_2_dice_1} & #{player_2_dice_2}, in total: #{player_2_Score}")
    
    if player_1_Score > player_2_Score
        puts("Player 1 wins!")
        p1_total += 1
    end
    
    if player_2_Score > player_1_Score
        puts("Player 2 wins!")
        p2_total += 1
    end
    
    if player_1_Score == player_2_Score
        puts("DRAW!")
        draw_total += 1
    end
    
    puts('')
    
    if p1_total == 5 || p2_total == 5
        puts("GAME OVER!")
        
        if p1_total !=1
            puts("Player 1 Won #{p1_total} times!")
        else
            puts("Player 1 Won #{p1_total} time!")
        end
        
        if p2_total !=1
            puts("Player 2 Won #{p2_total} times!")
        else
            puts("Player 2 Won #{p2_total} time!")
        end
        
        if draw_total !=1
            puts("There was #{draw_total} draws!")
        else
            puts("There was #{draw_total} draw!")
        end
        
        puts('')
        if p1_total > p2_total
            puts("PLAYER 1 WINS!")
        else
            puts("PLAYER 2 WINS!")
        end
        break
    end
    
end