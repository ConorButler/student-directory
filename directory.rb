@students = [] # an empty array accessible to all methods
def input_students
  # an empty input will break the loop below
  i = 0
  while i >= 0
    puts "Please enter the name of the student. Enter 'stop' to stop entering students"
    name = STDIN.gets.strip
    if name == "stop"
      break
    end
    @students << {name: name.capitalize} # << means .push/.append
    puts "Enter their cohort"
    cohort = STDIN.gets.strip
    until !cohort.empty?
      puts "Please enter something"
      cohort = STDIN.gets.strip
    end
    @students[i][:cohort] = cohort.capitalize # standardising the input
    puts "Enter the country they are from"
    country = STDIN.gets.strip
    until !country.empty?
      puts "Please enter something"
      country = STDIN.gets.strip
    end
    @students[i][:country] = country.capitalize
    puts "Enter their height in cm"
    height = STDIN.gets.strip
    until height.match(/^\d+$/) # making sure they only enter digits
      puts "Please enter a number"
      height = STDIN.gets.strip
    end
    @students[i][:height] = "#{height} cm"
    puts "Now we have #{@students.count} students"
    i += 1
  end
  # no longer needs to return students
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:country], student[:height]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def try_load_students
  filename = ARGV.first # first argument from the command line#
  return if filename.nil? # get of the method if this argument isn't given
  if File.exists?(filename) # if a file with this name exists
    load_students(filename) # load this file (and convert to hashes stored in @students)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end
  
def load_students(filename = "students.csv") # default filename if no argument supplied
  file = File.open(filename, "r")
  file.readlines.each do |line|
  name, cohort, country, height = line.chomp.split(',')
    @students << {name: name, cohort: cohort, country: country, height: height}
  end
  file.close
end

def print_header
  puts "The students of Villains Academy"
  puts "------------------------------"
end

# printing each student
def print_students_list
  index = 0
  if @students == nil
    return nil
  else
    puts "Enter the cohort you wish to print. Type enter to print all cohorts"
    cohort = STDIN.gets.strip.capitalize
    selected_cohort = @students.select{|student| student if student[:cohort] == cohort || cohort.empty?}
    puts "Print names beginning with which letter? Type enter to print all names"
    letter = STDIN.gets.strip.upcase
    print_header  # moved inside the print so it formats correctly
    until index == selected_cohort.length do
      if (selected_cohort[index][:name][0] == letter || letter.empty?) && selected_cohort[index][:name].length < 12
        print "#{index + 1}."
        puts "#{selected_cohort[index][:name]} (#{selected_cohort[index][:cohort]} cohort)".center(28)
        puts "Country: #{selected_cohort[index][:country]}".center(30)
        puts "Height: #{selected_cohort[index][:height]}".center(30)
      end
      index += 1
    end
  end
end

# printing the total number of students
def print_footer
  puts "------------------------------"
  if @students == nil
    puts "No students to print"
  elsif @students.length == 1
    puts "Overall, we have 1 great student"
  else
    puts "Overall, we have #{@students.count} great students"
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"  
end

def show_students
  print_students_list  # print_header is inside print
  print_footer
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
      puts "I don't know what you mean, try again"
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

# calling the menu
try_load_students
interactive_menu
