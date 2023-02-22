def start_screen
  croc_str = <<-'EXPECTED'
                               _ _ _      
                             | (_) |     
  ___ _ __ ___   ___ ___   __| |_| | ___ 
 / __| '__/ _ \ / __/ _ \ / _` | | |/ _ \
| (__| | | (_) | (_| (_) | (_| | | |  __/
 \___|_|  \___/ \___\___/ \__,_|_|_|\___|
               Press ENTER to begin...... 

  EXPECTED
  puts (croc_str)
end

def end_screen
  end_str = <<-'EXPECTED'
    _____                         ____                 
  / ____|                       / __ \                
 | |  __  __ _ _ __ ___   ___  | |  | |_   _____ _ __ 
 | | |_ |/ _` | '_ ` _ \ / _ \ | |  | \ \ / / _ \ '__|
 | |__| | (_| | | | | | |  __/ | |__| |\ V /  __/ |   
  \_____|\__,_|_| |_| |_|\___|  \____/  \_/ \___|_|   
                                                     
  EXPECTED
  puts(end_str)
end
 
def check_loc(symbol, river, location)
  river_temp = river.split(",")
  if river_temp[location[1]][location[0]] == symbol
    return true
  else
    return false
  end
end

def river_length(river, player_xy_location)
  river_temp = river.split(",")
  river_temp.shift()
  
  temp_arr = []
  
  7.times {
    letter = ["-","C","-"].sample
    if rand(10) > 8
      letter = "@"
    end
    temp_arr.push(letter)
  }
  
  temp_str = temp_arr.join("")
  river_temp.push(temp_str)
  
  river = river_temp.join(",")
  
  draw_river(river, player_xy_location[0], player_xy_location[1])
  
  return river
end

def draw_river(river, x_loc, y_loc)
  system("clear") || system("cls")
  river_temp = river.split(",")
  river_temp[y_loc][x_loc] = "P"
  river_temp.each { |layer|
    puts(layer)
  }
end

def add_new_player(score)
  new_player = []

  puts("Enter name")
  name = gets.chomp[0,4].upcase
  if name.length < 4
    name = name + "_"
  end

  new_player.push(name)
  new_player.push(score)
  
  return new_player
end

def load_leaderboard
  
  file = File.open("leaderboard.txt", "r")
  file_data = file.read
  file.close

  players_and_scores = file_data.split(",")
  leaderboard = []

  players_and_scores.each { |entry|
    temp = entry.split(":")
    leaderboard.push(temp)
  }

  leaderboard.each { |entry|
    entry[1] = entry[1].to_i
  }
  
  return leaderboard
end

def save_leaderboard(new_leaderboard)
  leaderboard_str = ""
  system("clear") || system("cls")
  puts("HIGHSCORES:")
  new_leaderboard.each { |entry|
    print(entry[0])
    print(" - ")
    print(entry[1])
    puts("")
    temp_str = entry[0]+":"+entry[1].to_s+","
    leaderboard_str += temp_str
  }

  File.open("leaderboard.txt", "w"){ |f| f.write(leaderboard_str) }
end

def highscore(score)
    
  leaderboard = load_leaderboard

  leaderboard.push(add_new_player(score))

  new_leaderboard = leaderboard.sort_by { |e| -e[1]}

  if new_leaderboard.length > 4
    new_leaderboard.pop()
  end

  save_leaderboard(new_leaderboard)
end

start_screen
gets.chomp

river = "-------,---C---,-CC-CC-,CCC-CCC,---C---"
loop = true
player_xy_location = [3, 0]
draw_river(river, player_xy_location[0], player_xy_location[1])
score = 0

while loop
  puts("")
  puts("Current score: #{score}")
  puts("Type left, right or neither")
  direction = gets.chomp
  puts("")
  
  if direction == "left"
    player_xy_location[0] -= 1
  elsif direction == "right"
    player_xy_location[0] += 1
  elsif direction == "neither"
    player_xy_location[0] = player_xy_location[0]
  else 
    player_xy_location[0] = player_xy_location[0]
  end
  
  score = score += 1
  river = river_length(river, player_xy_location)
  
  if check_loc("@", river, player_xy_location) == true
    score += 10
  end
  
  if check_loc("C", river, player_xy_location) == true
    system("clear") || system("cls")
    puts("You were eaten.")
    puts("Your final score is: #{score}")
    highscore(score)
    end_screen
    gets.chomp
    break
  end
end