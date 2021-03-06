    require 'csv'
    #Now does handle commas in data entry when saved to csv. 
    @students = []         #An empty array accessible to all methods.
    @student_st_lett = ""
    @default_cohort = "September"
    
    def interactive_menu 
      loop do
          print_menu
          process(STDIN.gets.gsub(/\n/,"")) #Alternative to ".chomp". Repeat for other occurrences of ".chomp".
      end
    end
    
    def print_menu
        puts "Enter the number corresponding to one of the following options:"
        puts "1 = Input the students"
        puts "2 = Show the students"
        puts "3 = Save the students to a file"
        #puts "4 = Load the list from \"students.csv\""
        puts "4 = Choose the students source file to load"
        puts "9 = Exit"
    end      
    
    def show_students
        if @students.count >= 1
            puts "Note: Only names shorter than 12 characters will be displayed."
            puts "Press \"Enter\" to return ALL students or enter a letter to show only student names beginning with that letter."
             @student_st_lett = STDIN.gets.chomp
            if @student_st_lett.empty?
                @student_st_lett = "all" 
            else    
                @student_st_lett = @student_st_lett[0].downcase  #first char selected if multiple are entered.
            end
        
            print_students_list
            print_footer
        else
            puts "There are no students to display."
        end
        @student_st_lett = ""
    end  
    
    def process(selection)
        case selection
          when "1"
              input_students
          when "2"
              show_students
          when "3"
              #save_students
              save_file
          when "4"
              #load_students
              load_file
          when "9"
              puts "The program has been closed."; puts
              exit
          else
              puts "That selection was not recognised. Please enter a number corresponding to the choices above."
        end          
    end    
    
    def input_students
        arr1 = get_student_userdata
        name, cohort, cob, hob, height, weight = arr1
        if name.empty?
            puts "No entry was made."
            return
        end
        while !name.empty?
            add_to_array(name, cohort, cob, hob, height, weight)
            puts "Student has been sucessfully added."; puts
            arr2 = get_student_userdata
            name, cohort, cob, hob, height, weight = arr2
            if name.empty?
                puts "You have exited data entry mode."; puts
                puts "We now have #{@students.count} students entered." if @students.count > 1 
                return
            end   
        end
    end 
    
    def get_student_userdata
        puts "Enter a student's name. Enter nothing to complete entry."
        puts "Enter a comma and then the cohort value. The default cohort \"#{@default_cohort}\" will be used if nothing is entered."
        val = STDIN.gets.chomp
        if val.empty?
            #puts "No entry was made."
            return [""] #Returning a value for name of ""
        else
            name, cohort = val.split(",").map(&:strip)
        end
        cohort = @default_cohort if cohort.nil?
        puts "Enter the country of birth of the student."
        cob = STDIN.gets.chomp 
        puts "Enter the student's hobbies."
        hob = STDIN.gets.chomp
        puts "Enter the student's height."
        height = STDIN.gets.chomp
        puts "Enter the student's weight."
        weight = STDIN.gets.chomp
        [name, cohort, cob, hob, height, weight]
    end
    
    #New method to comply with DRY principle - called twice!!!
    def add_to_array (name, cohort, countryofbirth, hobbies, height, weight)  
       @students << {name: name, cohort: cohort.to_sym, countryofbirth: countryofbirth.to_sym, hobbies: hobbies.to_sym,
           height: height.to_sym, weight: weight.to_sym}
    end    
    
    def print_header
        puts "The Students of Villains Academy".center(100)
        puts "________________________________".center(100)
    end
    
    def print_students_list
        #This is an alternative version to the 2 ways commented out below done using "while".
        
        puts "Do you want to print out all cohorts? Enter the month of the cohort, e.g. \"September\" to restrict the listing to that cohort only."
        puts "If you want to see all cohorts, just press enter."
        display_cohort = STDIN.gets.chomp.downcase
        print_header
        if display_cohort.empty?
            display_cohort = "all" 
        end  
        
        students_by_cohort =  @students             #Sorts into cohort order.
        students_by_cohort = students_by_cohort.sort_by {|entry|
            [entry[:cohort]]
        }
        
        if display_cohort != "all"
            students_by_cohort = students_by_cohort.delete_if {|value| 
                value[:cohort].to_s.downcase != display_cohort
            }
        end
        
        count = 0
        while count < students_by_cohort.length 
            if students_by_cohort[count][:name].length <= 12 && (students_by_cohort[count][:name][0].downcase == @student_st_lett || @student_st_lett == "all")
            name_pr = "No: #{count+1} => #{students_by_cohort[count][:name]}"
            cohort_pr = "(#{students_by_cohort[count][:cohort]} cohort)"
            cob_pr = "#{students_by_cohort[count][:countryofbirth]}"
            hob_pr = "#{students_by_cohort[count][:hobbies]}"
            height_pr = "#{students_by_cohort[count][:height]}"
            weight_pr = "#{students_by_cohort[count][:weight]}"
            puts name_pr.ljust(20) + cohort_pr.ljust(20) + cob_pr.ljust(20) + hob_pr.ljust(20) + height_pr.ljust(20) + weight_pr.ljust(20)
            end        
            count += 1
        end    
        puts "Successfully displayed the list of students."; puts
    end    
    
    def print_footer
        puts "Overall, we have #{@students.count} great student#{@students.count == 1 ? "." : "s."}"; puts
    end
 
    def save_file
        puts "Enter the name of the file to save to. Enter the name of an existing file or enter a new name to create a new file."
        file_to_save = STDIN.gets.chomp
        while file_to_save.empty?
            puts "Name cannot be blank. Please enter the name you wish to save the file as."
            file_to_save = STDIN.gets.chomp
        end
        if !File.exists? file_to_save
            puts "File \"#{file_to_save}\" does not yet exist. Are you sure you wish to create it?"
            puts "Press enter to create it or press \"n\" to cancel this operation."
            #return
            save_resp = STDIN.gets.chomp.downcase
            while save_resp != "n" && !save_resp.empty?
                puts "Please approve this operation by clicking enter or reject it by entering \"n\"."
                save_resp = STDIN.gets.chomp.downcase
            end 
        end
        if save_resp == "n"
            puts "You have successfully cancelled this save operation."; puts
        elsif save_resp.empty?         #User pressed enter to go ahead and save the file.
            filename = file_to_save
            save_students(filename)            
        end
    end
    
    def save_students(filename)
        CSV.open(filename, 'w') do |csv_object|
            @students.each do |student|
                student_data = [student[:name],student[:cohort],student[:countryofbirth],student[:hobbies],
                student[:height],student[:weight]]
                #print student_data; puts
                csv_object << student_data          #The array is just passed to csv_object. It does not need to be made into a string joined with (",")
            end
        end

        #file = File.open(filename,"w")
        #@students.each do |student|
        #    student_data = [student[:name],student[:cohort],student[:countryofbirth],student[:hobbies],student[:height],
        #    student[:weight]]
        #    csv_line = student_data.join(",")
        #    file.puts csv_line
        #end    
        #file.close
        puts "The file has been sucessfully saved."; puts
    end
    
    def load_file
       puts "Enter the name of the file to load:"
       file_to_load = STDIN.gets.chomp
       if !File.exists? file_to_load
           puts "Error: File \"#{file_to_load}\" does not exist."; puts
           return
       end
           filename = file_to_load
           load_students(filename)
    end
    
    def load_students (filename = "students.csv") #If "try_load_students" does not supply the file, then the default is used.   
       @students = []           #Prevents file loaded array from being concatenated to current array.
       CSV.foreach(filename, col_sep: ',') do |row|     #Col sep parameter defaults to comma anyway but included here anyway.
            #print row; puts
            name, cohort, countryofbirth, hobbies, height, weight = row
            add_to_array(name, cohort, countryofbirth, hobbies, height, weight)
       end
       #file = File.open(filename,"r")
       #file.readlines.each{|student|
       #    name, cohort, countryofbirth, hobbies, height, weight = student.chomp.split(",")
       #    #@students << {name: name, cohort: cohort.to_sym, countryofbirth: countryofbirth.to_sym, hobbies: hobbies.to_sym,
       #    #height: height.to_sym, weight: weight.to_sym}
       #    add_to_array(name, cohort, countryofbirth, hobbies, height, weight)
       #}
       #file.close
       puts "The file has been successfully loaded."; puts
    end  
    
    def try_load_students
        filename = ARGV.first   #First arg = "XXX" after the program call "directory.rb XXX"
        #return if filename.nil? #Abort trying to load a "non-default" (default = "students.csv") source file as no argument was supplied
        if filename.nil?
            load_students("students.csv")
            return
        end    
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
    
=begin
    @students = [{:name=>"Jason", :cohort=>:november, :countryofbirth=>:Zaire, :hobbies=>:tennis, :height=>:"6ft", 
    :weight=>:"80kg"}, etc.]
=end