students = ["Dr. Hannibal Lecter","Darth Vader","Nurse Ratched","Michael Corleone","Alex DeLarge","The Wicked Witch of the West",
"Terminator","Freddy Krueger","The Joker","Joffrey Baratheon","Norman Bates","The big green blob","Jonny Rotten",
"Dick Dastardly"]

def print_header
    puts "The Students of Villains Academy"
    puts "________________________________"
end

def print_names (names)
    names.each do |name|
        puts name
    end
end    

def print_footer (names)
    print "Overall, we have #{names.count} great students"
end

print_header
print_names (students)
print_footer (students)



