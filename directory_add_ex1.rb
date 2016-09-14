#I will do the exercises at the end.
@students = []         #An empty array accessible to all methods.

def interactive_menu 
  loop do
      print_menu
      process(STDIN.gets.chomp) #Note STDIN required to "reset" 'gets' after it has read the file argument from the command line.
  end
end

def print_menu
    puts "Enter the number corresponding to one of the following options:"
    puts "1 = Input the students"
    puts "2 = Show the students"
    puts "3 = Save the students to a file"
    puts "4 = Load the list from \"students.csv\""
    puts "9 = Exit"
end      

def show_students
    print_header
    print_students_list
    print_footer
end  

def process(selection)
    case selection
      when "1"
          students = input_students
      when "2"
          show_students
      when "3"
          save_students
      when "4"
          load_students
      when "9"
          exit
      else
          puts "That selection was not recognised!!!"
    end          
end    

def input_students
    puts "Enter a student's name."
    puts "Enter nothing to complete entry."
    val = gets.chomp
    #students_entries = []
    while !val.empty?
        @students << {name: val, cohort: :november}
        puts "We now have #{@students.count} students entered."
        val = gets.chomp
    end
    #students_entries
end    

def print_header
    puts "The Students of Villains Academy"
    puts "________________________________"
end

def print_students_list
    @students.each_with_index do |name, indx|
        puts "No: #{indx+1} => #{name[:name]} (#{name[:cohort]} cohort)"
    end
end    

def print_footer
    puts "Overall, we have #{@students.count} great students"
end

def save_students
    file = File.open("students.csv","w")
    @students.each do |student|
        student_data = [student[:name],student[:cohort]]
        csv_line = student_data.join(",")
        file.puts csv_line
    end    
    file.close
end

def load_students (filename = "students.csv") #If "try_load_students" does not supply the file, then the default is used.   
   file = File.open(filename,"r")
   file.readlines.each{|student|
       name, cohort = student.chomp.split(",")
       @students << {name: name, cohort: cohort.to_sym}
   }
   file.close
end  

def try_load_students
    filename = ARGV.first   #First arg = "XXX" after the program call "directory.rb XXX"
    return if filename.nil? #Abort trying to load a "non-default" (default = "students.csv") source file as no argument was supplied
    if File.exists?(filename)
        load_students(filename) #If the file exists it is passed to "load_students"
        puts "Loaded #{@students.count} students from file: \"#{filename}\""
    else
        puts "Error: File \"#{filename}\" does not exist."
    end    
end    

try_load_students
interactive_menu

interactive_menu

=begin
students = [{name: "Dr. Hannibal Lecter", cohort: :november},{name: "Darth Vader", cohort: :november},
{name: "Nurse Ratched", cohort: :november},{name: "Michael Corleone", cohort: :november},
{name: "Alex DeLarge", cohort: :november},{name: "The Wicked Witch of the West", cohort: :november},
{name: "Terminator", cohort: :november},{name: "Freddy Krueger", cohort: :november},
{name: "The Joker", cohort: :november},{name: "Joffrey Baratheon", cohort: :november},
{name: "Norman Bates", cohort: :november}]
=end