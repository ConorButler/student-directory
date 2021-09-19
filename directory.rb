def input_students
  # an empty input will break the loop below
  students = [] # stores list of students
  i = 0
  
  while i >= 0
    puts "Please enter the name of the student. Enter 'stop' to stop entering students"
    name = gets.strip
    if name == "stop"
      break
    end
    students << {name: name.capitalize} # << means .push/.append
    puts "Enter their cohort"
    cohort = gets.strip
    until !cohort.empty?
      puts "Please enter something"
      cohort = gets.strip
    end
    students[i][:cohort] = cohort.capitalize # standardising the input
    puts "Enter the country they are from"
    country = gets.strip
    until !country.empty?
      puts "Please enter something"
      country = gets.strip
    end
    students[i][:country] = country.capitalize
    puts "Enter their height in cm"
    height = gets.strip
    until height.match(/^\d+$/) # making sure they only enter digits
      puts "Please enter a number"
      height = gets.strip
    end
    students[i][:height] = "#{height} cm"
    puts "Now we have #{students.count} students"
    i += 1
  end
  # return the array of students (implicitly)
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

# printing each student
def print(students)
  index = 0
  if students == nil
    return nil
  else
    puts "Enter the cohort you wish to print"
    cohort = gets.strip.capitalize
    selected_cohort = students.select{|student| student if student[:cohort] == cohort}
    puts "Print student names beginning with which letter? Type enter to print all students"
    letter = gets.strip.upcase
    print_header  # moved inside the print so it formats correctly
    until index == selected_cohort.length do
      if (selected_cohort[index][:name][0] == letter || letter.empty?) && selected_cohort[index][:name].length < 12
        puts "#{index + 1}."
        puts "#{selected_cohort[index][:name]} (#{selected_cohort[index][:cohort]} cohort)".center(30)
        puts "Country: #{selected_cohort[index][:country]}".center(30)
        puts "Height: #{selected_cohort[index][:height]}".center(30)
      end
      index += 1
    end
  end
end

# printing the total number of students
def print_footer(students)
  if students == nil
    puts "No students to print"
  elsif students.length == 1
    puts "Overall, we have 1 great student"
  else
    puts "Overall, we have #{students.count} great students"
  end
end

# calling the methods
students = input_students
print(students)
print_footer(students)
