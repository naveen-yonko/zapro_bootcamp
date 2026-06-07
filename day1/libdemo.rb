books = []

def addbook(books)
  puts "Adding the book"
  print "Enter the book name: "
  name = gets.chomp.strip
  print "Enter the author name: "
  author = gets.chomp.strip
  print "Enter the publication year: "
  year = gets.chomp.to_i
  book = { name: name, author: author, year: year }
  books.push(book)  #books << book we can also use this
  puts "Book added successfully"
end

def listbooks(books)
  if books.empty?
    puts " library is empty"
  else
    puts "Top 3 books"
    books.first(3).each { |book| puts book[:name] +" by "+ book[:author] +" in "+ book[:year].to_s }#need to use .to_s as year is int
  end
end


def listallbooks(books)
  if books.empty?
    puts " library is empty"
  else
    puts "Listing all books"
    books.each do |book|
      puts " #{book[:name]} by #{book[:author]} in #{book[:year]}"
    end
  end
end

def searchbook(books)
  puts "Searching book"
  print "Enter the book name to search: "
  name = gets.chomp.downcase.strip
  books.find do |book|
    if book[:name].downcase == name
      puts "Book found: #{book[:name]} by #{book[:author]} in #{book[:year]}"
      return
    end
  end
  puts "Book not found"
end 

def uppdatebooks(books)
  print "Enter the book name to update: "
  name = gets.chomp.downcase.strip
  books.each do |book|
    if book[:name].downcase == name
      print "Enter the book new name: "
      n_name = gets.chomp.strip
      print "Enter the author new name: "
      n_author = gets.chomp.strip
      print "Enter the new publication year: "
      n_year = gets.chomp.to_i
      book[:name] = n_name
      book[:author] = n_author
      book[:year] = n_year
      puts "Book updated successfully"
      return
    end
  end
  puts "Book not found please enter a valid book name"
  
end 
def deletebook(books)
  print "Enter the book name to be delete: "
  name = gets.chomp.downcase.strip
  temp = books.reject! { |book| book[:name].downcase == name }
  if temp.nil?
    puts "Book not found please enter a valid book name"
  else
    puts "Book deleted successfully"
  end
end
def dev_stats(books)
  if books.empty?
    puts "Library is empty "
  else
    puts "total count #{books.count}"
    temp = books.count do |book|
      book[:year] > 2000
    end
    puts "Books published after 2000: #{temp}"
    temp = books.map { |book| book[:author] }
    uniq_auth = temp.uniq
    puts "Unique Auth List:"
    uniq_auth.each_with_index do |a,idx|
      puts " #{idx + 1}: #{a}"
    end
  end
end

def show_menu
  puts "Library Management System"
  puts "1. Add Book"
  puts "2. List Books"
  puts "3. Search Book"
  puts "4. Update Book"
  puts "5. Delete Book"
  puts "6. Exit"
  puts "7. List All Books"
  puts "8. dev sats"
  print "Enter your choice: "
end

loop do
    show_menu
    choice = gets.chomp.to_i
    case choice
    when 1
        addbook(books)
    when 2
        listbooks(books)
    when 3
        searchbook(books)
    when 4
        uppdatebooks(books)
    when 5
        deletebook(books)
    when 6
        puts "exiting Good bye !"
        break
    when 7
        listallbooks(books)
    when 8
        dev_stats(books)
    else
        puts "invalid choice please enter a valid option"
    end
end

=begin
Library Management System
1. Add Book
2. List Books
3. Search Book
4. Update Book
5. Delete Book
6. Exit
7. List All Books
8. dev sats
Enter your choice: 1
Adding the book
Enter the book name: harry
Enter the author name: JK
Enter the publication year: 2001
Book added successfully
Library Management System
1. Add Book
2. List Books
3. Search Book
4. Update Book
5. Delete Book
6. Exit
7. List All Books
8. dev sats
Enter your choice: 1
Adding the book
Enter the book name: potter
Enter the author name: rowling
Enter the publication year: 2002
Book added successfully
Library Management System
1. Add Book
2. List Books
3. Search Book
4. Update Book
5. Delete Book
6. Exit
7. List All Books
8. dev sats
Enter your choice: 1
Adding the book
Enter the book name: qwert
Enter the author name: trewq
Enter the publication year: 1999
Book added successfully
Library Management System
1. Add Book
2. List Books
3. Search Book
4. Update Book
5. Delete Book
6. Exit
7. List All Books
8. dev sats
Enter your choice: 3
Searching book
Enter the book name to search: harry
Book found: harry by JK in 2001
Library Management System
1. Add Book
2. List Books
3. Search Book
4. Update Book
5. Delete Book
6. Exit
7. List All Books
8. dev sats
Enter your choice: 7
Listing all books
 harry by JK in 2001
 potter by rowling in 2002
 qwert by trewq in 1999
Library Management System
1. Add Book
2. List Books
3. Search Book
4. Update Book
5. Delete Book
6. Exit
7. List All Books
8. dev sats
Enter your choice: 8
total count 3
Books published after 2000: 2
Unique Auth List:
 1: JK
 2: rowling
 3: trewq
Library Management System
1. Add Book
2. List Books
3. Search Book
4. Update Book
5. Delete Book
6. Exit
7. List All Books
8. dev sats
Enter your choice: 6
exiting Good bye !
=end
