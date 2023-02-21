def decision(choice)
  seed = rand(1..3)
  
  if choice == "LEFT"
    if seed == 1
        return "DEAD - WOLF"
    end
    if seed == 2
        return "DEAD - GOBLIN"
    end
    if seed == 3
        return "SURVIVE"
    end
  end
  
  if choice == "RIGHT"
    if seed == 2
        return "DEAD - WOLF"
    end
    if seed == 3
        return "DEAD - GOBLIN"
    end
    if seed == 1
        return "SURVIVE"
    end
  end
  
  if choice == "FORWARD"
    if seed == 3
        return "DEAD - WOLF"
    end
    if seed == 1
        return "DEAD - GOBLIN"
    end
    if seed == 2
        return "SURVIVE"
    end
  end
  
  return "ERROR"
end


loops = 0

while true
  puts("You are in a dungeon...")
  puts("You see a sign on the wall with #{loops} written on it...")
  puts("Do you go LEFT, RIGHT, or FORWARD?")
  direction = gets.chomp.upcase
  result = decision(direction)
  
  if result == "SURVIVE"
      loops += 1
      puts("You survived, this time...")
  end
  
  if result == "DEAD - GOBLIN"
      puts("You were attacked by a goblin!")
      puts("You died!")
      if loops != 1
        puts("You survived #{loops} times")
      else
        puts("You survived #{loops} time")
      end
      break
  end
  
  if result == "DEAD - WOLF"
      puts("You were attacked by a werewolf!")
      puts("You died!")
      if loops != 1
        puts("You survived #{loops} times")
      else
        puts("You survived #{loops} time")
      end
      break
  end
  
end
      



