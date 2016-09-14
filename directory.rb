students = [{name: "Dr. Hannibal Lecter", cohort: :november},{name: "Darth Vader", cohort: :november},
{name: "Nurse Ratched", cohort: :november},{name: "Michael Corleone", cohort: :november},
{name: "Alex DeLarge", cohort: :november},{name: "The Wicked Witch of the West", cohort: :november},
{name: "Terminator", cohort: :november},{name: "Freddy Krueger", cohort: :november},
{name: "The Joker", cohort: :november},{name: "Joffrey Baratheon", cohort: :november},
{name: "Norman Bates", cohort: :november}]

def print_header
    puts "The Students of Villains Academy"
    puts "________________________________"
end

def print_names (names)
    names.each do |name|
        puts "#{name[:name]} (#{name[:cohort]} cohort)"
    end
end    

def print_footer (names)
    print "Overall, we have #{names.count} great students"
end

print_header
print_names (students)
print_footer (students)



