#Does not handle commas in data entry when saved to csv. Commas need to be escaped or complete entry needs to be put in quotes.
@students = []         #An empty array accessible to all methods.
@student_st_lett = ""

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
    puts "Note: Only names shorter than 12 characters will be displayed."
    puts "Press \"Enter\" to return ALL students or enter a letter to show only student names beginning with that letter."
     @student_st_lett = STDIN.gets.chomp
    if @student_st_lett.empty?
        @student_st_lett = "all" 
    else    
        @student_st_lett = @student_st_lett[0].downcase  #first char selected if multiple are entered.
    end
    print_header
    print_students_list
    print_footer
    @student_st_lett = ""
end  

def process(selection)
    case selection
      when "1"
          input_students
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
    puts "Enter a student's name. Enter nothing to complete entry."
    val = STDIN.gets.chomp
    if val.empty?
        puts "No entry was made."
        return
    end
    puts "Enter the country of birth of the student."
    cob = STDIN.gets.chomp 
    puts "Enter the student's hobbies."
    hob = STDIN.gets.chomp
    puts "Enter the student's height."
    height = STDIN.gets.chomp
    puts "Enter the student's weight."
    weight = STDIN.gets.chomp
    
    while !val.empty?
        @students << {name: val, cohort: :november, countryofbirth: cob, hobbies: hob, height: height, weight: weight}
        puts "Enter a student's name. Enter nothing to complete entry."
        val = STDIN.gets.chomp
        if val.empty?
            puts "We now have #{@students.count} students entered." if @students.count > 1 
            return
        end
        puts "Enter the country of birth of the student."
        cob = STDIN.gets.chomp
        puts "Enter the student's hobbies."
        hob = STDIN.gets.chomp
        puts "Enter the student's height."
        height = STDIN.gets.chomp
        puts "Enter the student's weight."
        weight = STDIN.gets.chomp
    end
end    

def print_header
    puts "The Students of Villains Academy"
    puts "________________________________"
end

def print_students_list
    #This is an alternative version to the 2 ways commented out below done using "while".
    count = 0
    while count < @students.length 
        if @students[count][:name].length <= 12 && (@students[count][:name][0].downcase == @student_st_lett || @student_st_lett == "all")
            puts "No: #{count+1} => #{@students[count][:name]} (#{@students[count][:cohort]} cohort) 
            #{@students[count][:countryofbirth]} #{@students[count][:hobbies]} #{@students[count][:height]} 
            #{@students[count][:weight]}"
        end        
        count += 1
    end    
=begin
    This is an alternative version of the "each_with_index" below but using "until". This code works!
    count = 0
    until count >= @students.length 
        if @students[count][:name].length <= 12 && (@students[count][:name][0].downcase == @student_st_lett || @student_st_lett == "all")
            puts "No: #{count+1} => #{@students[count][:name]} (#{@students[count][:cohort]} cohort)"
        end        
        count += 1
    end
=end    
=begin    
    Code below rewritten as an "until" loop above. This code works!
    @students.each_with_index do |name, indx|
        if name[:name].length <= 12 && (name[:name][0].downcase == @student_st_lett || @student_st_lett == "all")
            puts "No: #{indx+1} => #{name[:name]} (#{name[:cohort]} cohort)"
        end    
    end
=end    
end    

def print_footer
    puts "Overall, we have #{@students.count} great students"
end

def save_students
    file = File.open("students.csv","w")
    @students.each do |student|
        student_data = [student[:name],student[:cohort],student[:countryofbirth],student[:hobbies],student[:height],
        student[:weight]]
        csv_line = student_data.join(",")
        file.puts csv_line
    end    
    file.close
end

def load_students (filename = "students.csv") #If "try_load_students" does not supply the file, then the default is used.   
   file = File.open(filename,"r")
   file.readlines.each{|student|
       name, cohort, countryofbirth, hobbies, height, weight = student.chomp.split(",")
       @students << {name: name, cohort: cohort.to_sym, countryofbirth: countryofbirth.to_sym, hobbies: hobbies.to_sym,
       height: height.to_sym, weight: weight.to_sym}
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


=begin
students = [{name: "Dr. Hannibal Lecter", cohort: :november},{name: "Darth Vader", cohort: :november},
{name: "Nurse Ratched", cohort: :november},{name: "Michael Corleone", cohort: :november},
{name: "Alex DeLarge", cohort: :november},{name: "The Wicked Witch of the West", cohort: :november},
{name: "Terminator", cohort: :november},{name: "Freddy Krueger", cohort: :november},
{name: "The Joker", cohort: :november},{name: "Joffrey Baratheon", cohort: :november},
{name: "Norman Bates", cohort: :november}]
=end