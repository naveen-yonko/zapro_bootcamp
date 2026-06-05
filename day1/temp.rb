puts "hello world"
print "hello world\n"
p "hello world"

name = "Naveen"
age = 22

puts name
puts age

name = "Naveen"
age = 22

puts "Name: %s Age: %d" % [name, age]
puts "Name: #{name} Age: #{age}"

puts "Enter your name: "
name = gets
puts name
# hidden newline (\n) at the end.
puts "Enter your name: "
name = gets.chomp

puts "Hello #{name}"
#chomp removes the newline character


#LETS USE PRINT SO DISPLAY ON SAME LINE 
print "Enter your age: "
age = gets.chomp.to_i
puts age + 5
puts age
#gets.chomp.to_i converts the input to an integer.


a, b = gets.chomp.split.map(&:to_i)

puts a
puts b
#gets.chomp.split splits the input into an array of strings, and map(&:to_i) converts each element to an integer.



print "Enter your name: "
name = gets.chomp

print "Enter your age: "
age = gets.chomp.to_i

puts "Hello #{name}"
puts "Next year you will be #{age + 1}"


age = 20

if age >= 18
  puts "Adult"
end


age = 15

if age >= 18
  puts "Adult"
else
  puts "Minor"
end

marks = 75

if marks >= 90
  puts "A"
elsif marks >= 75
  puts "B"
elsif marks >= 50
  puts "C"
else
  puts "Fail"
end


age = 20

puts "Adult" if age >= 18

age = 25
salary = 50000

if age > 18 && salary > 30000
  puts "Eligible"
end

day = "Monday"

case day
when "Monday"
  puts "Start of week"
when "Friday"
  puts "Weekend soon"
else
  puts "Normal day"
end
 # we dont have ++ or -- operators in Ruby  we can use += or -= instead.



 # loops 

 i = 1

while i <= 5
  puts i
  i += 1
end


i = 1

until i > 5
  puts i
  i += 1
end
# !while   while(true) runs until(false) runs

5.times do |i|
  puts i
end


numbers = [10, 20, 30]

numbers.each do |num|
  puts num
end


i = 1

while true
  puts i

  break if i == 5

  i += 1
end


i = 1

while true
  puts i

  break if i == 5

  i += 1
end

for i in 1..5
  puts i
end

fruits = ["Apple", "Banana", "Mango"]

for fruit in fruits
  puts fruit
end

fruits = ["Apple", "Banana", "Mango"]

fruits.each do |fruit|
  puts fruit
end


fruits = ["Apple", "Banana", "Mango"]

fruits.each_with_index do |fruit, index|
  puts "#{index}: #{fruit}"
end