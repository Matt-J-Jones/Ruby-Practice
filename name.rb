puts String.new("Hello, what is your name?")
name = gets.chomp

if name[0].upcase == 'S'
    puts(name.upcase)
else
    puts("Hi #{name}!")
end
