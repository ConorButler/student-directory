def input_students
  puts "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  # an empty input will break the loop below
  students = [] # stores list of students
  i = 0
  
  while i >= 0
    puts "Please enter the name of the student. Enter 'stop' to stop entering students"
    name = gets.chomp
    if name == "stop"
      break
    end
    students << {name: name} # << means .push/.append
    puts "Enter their cohort"
    cohort = gets.chomp
    students[i][:cohort] = cohort
    puts "Enter the country they are from"
    country = gets.chomp
    students[i][:country] = country
    puts "Enter their height in cm"
    height = gets.chomp
    students[i][:height] = height
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
  puts "Print student names beginning with which letter? Type enter to print all students"
  letter = gets.chomp.upcase
  index = 0
  until index == students.length do
    if (students[index][:name].upcase[0] == letter || letter.empty?) && students[index][:name].length < 12
      puts "#{index + 1}."
      puts "#{students[index][:name]} (#{students[index][:cohort]} cohort)".center(30)
      puts "Country: #{students[index][:country]}".center(30)
      puts "Height: #{students[index][:height]}cm".center(30)
    end
    index += 1
  end
end

# printing the total number of students
def print_footer(students)
  if students.length == 1
    puts "Overall, we have 1 great student"
  else
    puts "Overall, we have #{students.count} great students"
  end
end

# calling the methods
students = input_students
print_header
print(students)
print_footer(students)
