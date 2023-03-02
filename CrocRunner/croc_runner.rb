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
  gets.chomp
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
 
def check_loc(symbol, river)
  # checks the players current location against the river map
  # returns true if over specified symbol (used for checking crocodiles and bonuses)
  
  river_temp = river.split(",")
  if river_temp[@player_xy_location[1]][@player_xy_location[0]] == symbol
    return true
  else
    return false
  end
end

def river_length(river)
  # Removes the top line of the river, randomly generates a new line to replace it
  # appends new line to the bottom of the river. Returns new river.
  
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
  
  draw_river(river)
  
  return river
end

def draw_river(river)
  # Draws the river from the input variable
  system("clear") || system("cls")
  river_temp = river.split(",")
  river_temp[@player_xy_location[1]][@player_xy_location[0]] = "P"
  river_temp.each { |layer|
    puts(layer)
  }
end

def add_new_player
  # adds new players name to the scoreboard
  # if players name is over 4 charaters, cuts off after 4th
  # if players name is under 5, it fills in the rest with underscores
  # returns name and score
  
  new_player = []

  puts("Enter name")
  name = gets.chomp[0,4].upcase
  if name.length < 4
    blanks = 4 - name.length
    blanks.times {
    name = name + "_"
    }
  end

  new_player.push(name)
  new_player.push(@score)
  
  return new_player
end

def load_leaderboard
  # loads leaderboard from file, splits into array of name (str) and score (int)
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
  # prints leaderboard to console and updates leaderboard file
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

def highscore
  # loads current leaderboard, adds in player name and score.
  # sorts leaderboard, and pops off lowest score
  
  leaderboard = load_leaderboard

  leaderboard.push(add_new_player)

  new_leaderboard = leaderboard.sort_by { |e| -e[1]}

  if new_leaderboard.length > 4
    new_leaderboard.pop()
  end

  save_leaderboard(new_leaderboard)
end

start_screen


river = "-------,---C---,-CC-CC-,CCC-CCC,---C---"
@player_xy_location = [3, 0]
draw_river(river)
@score = 0

while true
  puts("")
  puts("Current score: #{@score}")
  puts("Type left, right or neither")
  direction = gets.chomp
  puts("")
  
  if direction == "left"
    @player_xy_location[0] -= 1
  elsif direction == "right"
    @player_xy_location[0] += 1
  elsif direction == "neither"
    @player_xy_location[0] = @player_xy_location[0]
  else 
    next
  end
  
  @score += 1
  river = river_length(river)
  
  if check_loc("@", river) == true
    @score += 10
  end
  
  if check_loc("C", river) == true
    system("clear") || system("cls")
    puts("You were eaten.")
    puts("Your final score is: #{@score}")
    highscore
    end_screen
    gets.chomp
    break
  end
end