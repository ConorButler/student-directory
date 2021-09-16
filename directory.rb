def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice" # an empty input will break the loop below
  students = [] # stores list of students
  name = gets.chomp  # discards return (newline)
  while !name.empty? do # if the user inputs something
    students << {name: name, cohort: :november} # << means .push/.append
    puts "Now we have #{students.count} students"
    name = gets.chomp
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
  puts "Print student names beginning with which letter? Type enter to print all students"
  letter = gets.chomp
  index = 0
  until index == students.length - 1 do
    if (students[index][:name].downcase[0] == (letter.downcase) || letter.empty?) && students[index][:name].length < 12
      puts "#{index + 1}. #{students[index][:name]} (#{students[index][:cohort]} cohort)"
    end
    index += 1
  end
end

# printing the total number of students
def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

# calling the methods
students = input_students
print_header
print(students)
print_footer(students)
