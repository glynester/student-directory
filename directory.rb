#I will do the exercises at the end.
def interactive_menu 
  students = []
  loop do
      puts "Enter the number corresponding to one of the following options:"
      puts "1 = Input the students"
      puts "2 = Show the students"
      puts "9 = Exit"
      selection = gets.chomp
      case selection
      when "1"
          students = input_students
      when "2"
          print_header
          print_names (students)
          print_footer (students)
      when "9"
          exit
      else
          puts "That selection was not recognised!!!"
      end      
  end
end


def input_students
    puts "Enter a student's name."
    puts "Enter nothing to complete entry."
    val = gets.chomp
    students_entries = []
    while !val.empty?
        students_entries << {name: val, cohort: :november}
        puts "We now have #{students_entries.count} students entered."
        val = gets.chomp
    end
    students_entries
end    

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

interactive_menu

=begin
students = [{name: "Dr. Hannibal Lecter", cohort: :november},{name: "Darth Vader", cohort: :november},
{name: "Nurse Ratched", cohort: :november},{name: "Michael Corleone", cohort: :november},
{name: "Alex DeLarge", cohort: :november},{name: "The Wicked Witch of the West", cohort: :november},
{name: "Terminator", cohort: :november},{name: "Freddy Krueger", cohort: :november},
{name: "The Joker", cohort: :november},{name: "Joffrey Baratheon", cohort: :november},
{name: "Norman Bates", cohort: :november}]
=end



