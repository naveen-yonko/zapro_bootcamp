books = []

def add_book(books)
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

def list_books(books)
  if books.empty?
    puts " library is empty"
  else
    puts "Top books"
    books.first(3).each { |book| puts book[:name] +" by "+ book[:author] +" in "+ book[:year].to_s + " (" + book[:genre] + ")" }#need to use .to_s as year is int
  end
end 


def list_all_books(books)
  if books.empty?
    puts " library is empty"
  else
    puts "Listing all books"
    books.each do |book|
      puts " #{book[:name]} by #{book[:author]} in #{book[:year]} (#{book[:genre]})"
    end
  end
end

def search_book(books)
  if books.empty?
    puts " library is empty"
  else
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
end 
def search_genre(books)
  if books.empty?
    puts " library is empty"
  else
    puts "Searching book by genre "
    print "Enter the book genre to search: "
    genre = gets.chomp.downcase.strip
    gen_filter = books.reject { |book| book[:genre].downcase != genre }
    if gen_filter.empty?
      puts "no book found in this genre"
    else
      gen_filter.each { |book| puts "Book found: #{book[:name]} by #{book[:author]} in #{book[:year]} (#{book[:genre]})" }
    end
  end
end 

def update_book(books)
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
def delete_book(books)
  print "Enter the book name to be delete: "
  name = gets.chomp.downcase.strip
  temp = books.reject! { |book| book[:name].downcase == name }
  if temp.nil?
    puts "Book not found please enter a valid book name"
  else
    puts "Book deleted successfully"
  end
end

def spanish_menu
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

def book_summary(books)
  if books.empty?
    puts "Library is empty \n no recent books or old books"
  else
    least = books.first[:year]
    least_book = books.first[:name]
    puts "books Summary"
    puts "Total books: #{books.length}"
    books.each do |book|
      if book[:year] < least
        least = book[:year]
        least_book = book[:name]
      end
    end
    puts "Oldest book: #{least_book} in our library released in #{least}"
    puts "Recent Book: #{books[-1][:name]} in our library"
  end
end


def display_menu
  puts "~~~~~~~Welcome to the library Management System~~~~~~~"
  puts "1. Add book"
  puts "2. list book"
  puts "3. search book"
  puts "4. uppdate book"
  puts "5. delete book"
  puts "6. exit"
  puts"7. list all books"
  puts "8.search by genere"
  puts "9.book_summary"
  print "Enter your choice: "
end


loop do
  display_menu
  choice = gets.chomp
    case choice
    when "0"
        spanish_menu
    when "1"
      add_book(books)
    when "2"
      list_books(books)
    when "3"
      search_book(books)
    when "4"
      update_book(books)
    when "5"
      delete_book(books)
    when "6"
      puts "Exit Good bye !"
      break
    when "7"
      list_all_books(books)
    when "8"
      search_genre(books)
    when "9"
      book_summary(books)
    else
      puts "Invalid choice please enter a valid option"
    end
end

=begin
~~~~~~Welcome to the library Management System~~~~~~~
1. Add book
2. list book
3. search book
4. uppdate book
5. delete book
6. exit
7. list all books
8.search by genere
9.book_summary
Enter your choice: 7
Listing all books
 harry potter by J K Rowling in 2000 (Fiction)
 Ruby on Rails by zzzz in 2024 (Education)
 Software Engineering by www in 2025 (Education)
 old book and recent added by zzz in 1999 (Uncategorized)


~~~~~~~Welcome to the library Management System~~~~~~~
1. Add book
2. list book
3. search book
4. uppdate book
5. delete book
6. exit
7. list all books
8.search by genere
9.book_summary
Enter your choice: 9
books Summary
Total books: 4
Oldest book: old book and recent added in our library released in 1999
Recent Book: old book and recent added in our library
=end
