while true
  puts "~~~~~~~Welcome to the library Management System~~~~~~~"
  puts "1. Add book"
  puts "2. list book"
  puts "3. search book"
  puts "4. uppdate book"
  puts "5. delete book"
  puts "6. exit"
  print "Enter your choice: "
    choice = gets.chomp.to_i
    case choice
    when 1
      puts "Adding the book"
    when 2
      puts "Listing  book"
    when 3
      puts "Search book"
    when 4
      puts "Update book"
    when 5
      puts "Delete book"
    when 6
      puts "Exit"
      break
    else
      puts "Invalid choice please enter a valid option"
    end
end


=begin
~~~~~~~output~~~~~~~
~~~~~~~Welcome to the library Management System~~~~~~~
1. Add book
2. list book
3. search book
4. uppdate book
5. delete book
6. exit
Enter your choice: 1
Adding the book
~~~~~~~Welcome to the library Management System~~~~~~~
1. Add book
2. list book
3. search book
4. uppdate book
5. delete book
6. exit
Enter your choice: 2
Listing  book
~~~~~~~Welcome to the library Management System~~~~~~~
1. Add book
2. list book
3. search book
4. uppdate book
5. delete book
6. exit
Enter your choice: 3
Search book
~~~~~~~Welcome to the library Management System~~~~~~~
1. Add book
2. list book
3. search book
4. uppdate book
5. delete book
6. exit
Enter your choice: 6
Exit

=end
