@students = []
months = ["January", "February", "March", "April", "May", "June",
"July", "August", "September", "October", "November", "December"]
# this will be joined with the .union method to create a month regexp
# months could be removed from this list if they are full
@input = [
{:field => :name, :prompt => "Enter the name of the student", :requirement => /^[a-zA-Z]+$/},
{:field => :cohort, :prompt => "Enter their cohort", :requirement => Regexp.union(months)},
{:field => :country, :prompt => "Enter the country they are from", :requirement => /^\w+$/},
{:field => :height, :prompt => "Enter their height in cm e.g. 160cm", :requirement => /^\d+cm$/}
]

def add_students(data)
  name, cohort, country, height = data
  @students << {name: name, cohort: cohort, country: country, height: height}
end

def try_load_students
  ARGV.first.nil? ? filename = "students.csv" : filename = ARGV.first
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
    add_students(line.chomp.split(','))
  end
  file.close
end

def input_students
  data = []
  @input.each do |field|
    puts field[:prompt]
    user_input = STDIN.gets.strip.capitalize
    until user_input.match?(field[:requirement])
      puts "Error, please enter a valid #{field[:field]}"
      user_input = STDIN.gets.strip.capitalize
    end
    data << user_input
  end
  add_students(data)
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

def print_header
  puts "The students of Villains Academy"
  puts "------------------------------"
end

# printing each student
def print_students_list(selected_cohort, letter)
  index = 0
  until index == selected_cohort.length do
    if (selected_cohort[index][:name][0] == letter || letter.empty?) && selected_cohort[index][:name].length < 12
      puts "#{index + 1}." + "#{selected_cohort[index][:name]} (#{selected_cohort[index][:cohort]} cohort)".center(28)
      puts "Country: #{selected_cohort[index][:country]}".center(30)
      puts "Height: #{selected_cohort[index][:height]}".center(30)
    end
    index += 1
  end
end

# printing the total number of students
def print_footer
  puts "------------------------------"
  if @students.empty?
    puts "No students to print"
  elsif @students.length == 1
    puts "Overall, we have 1 great student"
  else
    puts "Overall, we have #{@students.count} great students"
  end
end

def show_students
  puts "Enter the cohort you wish to print. Type enter to print all cohorts"
  cohort = STDIN.gets.strip.capitalize
  selected_cohort = @students.select{|student| student if student[:cohort] == cohort || cohort.empty?}
  puts "Print names beginning with which letter? Type enter to print all names"
  letter = STDIN.gets.strip.upcase
  print_header
  print_students_list(selected_cohort, letter) if !@students.empty?
  print_footer
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"  
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
