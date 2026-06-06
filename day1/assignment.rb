books = []

def addbook(books)
  puts "Adding the book"
  print "Enter the book name: "
  name = gets.chomp.strip
  print "Enter the author name: "
  author = gets.chomp.strip
  print "Enter the publication year: "
  year = gets.chomp.to_i
  print "Enter the book genre: "
  genre = gets.chomp.strip
  if genre.empty?
    genre = "Uncategorized"
  end
  book = { name: name, author: author, year: year, genre: genre }
  books.push(book)  #books << book we can also use this
  puts "Book added successfully"
end

def listbooks(books)
  puts "Top 3 books"
  books.first(3).each { |book| puts book[:name] +" by "+ book[:author] +" in "+ book[:year].to_s + " (" + book[:genre] + ")" }#need to use .to_s as year is int
end 


def listallbooks(books)
  puts "Listing all books"
  books.each do |book|
    puts " #{book[:name]} by #{book[:author]} in #{book[:year]} (#{book[:genre]})"
  end
end

def searchbook(books)
  puts "Searching book"
  print "Enter the book name to search: "
  name = gets.chomp.downcase.strip
  books.each do |book|
    if book[:name].downcase == name
      puts "Book found: #{book[:name]} by #{book[:author]} in #{book[:year]} (#{book[:genre]})"
      return
    end
  end
  puts "Book not found"
  
end 
def searchgenere(books)
  puts "Searching book by genere "
  print "Enter the book Genere to search: "
  genre = gets.chomp.downcase.strip
  gen_filter = books.reject { |book| book[:genre].downcase != genre }
  if gen_filter.empty?
    puts "no book found in this genere"
  else
    gen_filter.each { |book| puts "Book found: #{book[:name]} by #{book[:author]} in #{book[:year]} (#{book[:genre]})" }
  end
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
      print "Enter the new book genre: "
      n_genre = gets.chomp.strip
      if n_genre.empty?
        n_genre = "Uncategorized"
      end

      book[:name] = n_name
      book[:author] = n_author
      book[:year] = n_year
      book[:genre] = n_genre
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

def spanishmenu
    puts "sistema de gestion de biblioteca (menu oculto español)"
    puts "1. agregar libro"
    puts "2. listar libro"
    puts "3. buscar libro"
    puts "4. actualizar libro"
    puts "5. eliminar libro"
    puts "6. salir"
    puts "Press Enter to return to English menu"
    gets.chomp
end


while true
  puts "~~~~~~~Welcome to the library Management System~~~~~~~(hidden menu spanish)"
  puts "1. Add book"
  puts "2. list book"
  puts "3. search book"
  puts "4. uppdate book"
  puts "5. delete book"
  puts "6. exit"
  puts"7. list all books"
  puts "8.search by genere"
  print "Enter your choice: "
    choice = gets.chomp
    case choice
    when "0"
        spanishmenu
    when "1"
      addbook(books)
    when "2"
      listbooks(books)
    when "3"
      searchbook(books)
    when "4"
      uppdatebooks(books)
    when "5"
      deletebook(books)
    when "6"
      puts "Exit Good bye !"
      break
    when "7"
      listallbooks(books)
    when "8"
      searchgenere(books)
    else
      puts "Invalid choice please enter a valid option"
    end
end

=begin 
========output======== 
~~~~~~Welcome to the library Management System~~~~~~~(hidden menu spanish)
1. Add book
2. list book
3. search book
4. uppdate book
5. delete book
6. exit
7. list all books
8.search by genere
Enter your choice: 1
Adding the book
Enter the book name: Harry Potter
Enter the author name: J K Rowling
Enter the publication year: 2000
Enter the book genre: fiction
Book added successfully
~~~~~~~Welcome to the library Management System~~~~~~~(hidden menu spanish)
1. Add book
2. list book
3. search book
4. uppdate book
5. delete book
6. exit
7. list all books
8.search by genere
Enter your choice: 1
Adding the book
Enter the book name: Atomic Habits
Enter the author name: James Clear
Enter the publication year: 2024
Enter the book genre: self motivation
Book added successfully
~~~~~~~Welcome to the library Management System~~~~~~~(hidden menu spanish)
1. Add book
2. list book
3. search book
4. uppdate book
5. delete book
6. exit
7. list all books
8.search by genere
Enter your choice: 2
Top 3 books
Harry Potter by J K Rowling in 2000 (fiction)
Atomic Habits by James Clear in 2024 (self motivation)
~~~~~~~Welcome to the library Management System~~~~~~~(hidden menu spanish)
1. Add book
2. list book
3. search book
4. uppdate book
5. delete book
6. exit
7. list all books
8.search by genere
Enter your choice: 1
Adding the book
Enter the book name: ruby
Enter the author name: aaaa
Enter the publication year: 2005
Enter the book genre: 
Book added successfully
~~~~~~~Welcome to the library Management System~~~~~~~(hidden menu spanish)
1. Add book
2. list book
3. search book
4. uppdate book
5. delete book
6. exit
7. list all books
8.search by genere
Enter your choice: 7
Listing all books
 Harry Potter by J K Rowling in 2000 (fiction)
 Atomic Habits by James Clear in 2024 (self motivation)
 ruby by aaaa in 2005 (Uncategorized)
~~~~~~~Welcome to the library Management System~~~~~~~(hidden menu spanish)
1. Add book
2. list book
3. search book
4. uppdate book
5. delete book
6. exit
7. list all books
8.search by genere
Enter your choice: 3
Searching book
Enter the book name to search: ruby
Book found: ruby by aaaa in 2005 (Uncategorized)
~~~~~~~Welcome to the library Management System~~~~~~~(hidden menu spanish)
1. Add book
2. list book
3. search book
4. uppdate book
5. delete book
6. exit
7. list all books
8.search by genere
Enter your choice: 4
Enter the book name to update: ruby
Enter the book new name: ruby
Enter the author new name: sss 
Enter the new publication year: 2005
Enter the new book genre: 
Book updated successfully
~~~~~~~Welcome to the library Management System~~~~~~~(hidden menu spanish)
1. Add book
2. list book
3. search book
4. uppdate book
5. delete book
6. exit
7. list all books
8.search by genere
Enter your choice: 5
Enter the book name to be delete: ruby
Book deleted successfully
~~~~~~~Welcome to the library Management System~~~~~~~(hidden menu spanish)
1. Add book
2. list book
3. search book
4. uppdate book
5. delete book
6. exit
7. list all books
8.search by genere
Enter your choice: 5
Enter the book name to be delete: qwerty
Book not found please enter a valid book name
~~~~~~~Welcome to the library Management System~~~~~~~(hidden menu spanish)
1. Add book
2. list book
3. search book
4. uppdate book
5. delete book
6. exit
7. list all books
8.search by genere
Enter your choice: 7
Listing all books
 Harry Potter by J K Rowling in 2000 (fiction)
 Atomic Habits by James Clear in 2024 (self motivation)
~~~~~~~Welcome to the library Management System~~~~~~~(hidden menu spanish)
1. Add book
2. list book
3. search book
4. uppdate book
5. delete book
6. exit
7. list all books
8.search by genere
Enter your choice: 6
Exit Good bye !
=end