books = [
  { name: "To Kill a Mockingbird", author: "Harper Lee", year: 1960 },
  { name: "The Great Gatsby", author: "F. Scott Fitzgerald", year: 1925 },
  { name: "Harry Potter", author: "J.K. Rowling", year: 1997 },
  { name: "The Da Vinci Code", author: "Dan Brown", year: 2003 },
  { name: "The Hunger Games", author: "Suzanne Collins", year: 2008 },
  { name: "Project Hail Mary", author: "Andy Weir", year: 2021 },
  { name: "The Alchemist", author: "Paulo Coelho", year: 1988 },
]

def validate_input(value, field_name)
if value.strip.empty?
puts "#{field_name} cannot be blank."
return false
end
true
end


def addbook(books)
  puts "Adding the book"

  print "Enter the book name: "
  name = gets.chomp.strip
  if !validate_input(name, "Book name")
    return
  end

  print "Enter the author name: "
  author = gets.chomp.strip
  if !validate_input(author, "Author name")
    return
  end

  print "Enter the publication year: "
  year = gets.chomp.to_i
  if year <= 0
    puts "Publication year must be a positive integer."
    return
  end

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
  name = gets.chomp.downcase
  if !validate_input(name, "Book name")
    return
  end
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
  if !validate_input(name, "Book name")
    return
  end
  books.each do |book|
    if book[:name].downcase == name
      print "Enter the book new name: "
      n_name = gets.chomp.strip
      if !validate_input(n_name, "Book name")
        return
      end
      puts "Rename #{book[:name]} --> #{n_name}(y/n)"
      reply = gets.chomp.downcase.strip
      if reply == 'n'
        puts "Update cancelled"
        return
      end
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
  if !validate_input(name, "Book name")
    return
  end

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

def books_btw_years(books)
  if books.empty?
    puts "Library is empty "
  else
    puts "Books between years"
    print "Enter the start year: "
    strt_year = gets.chomp.to_i
    print "Enter the end year: "
    end_year = gets.chomp.to_i
    if strt_year > end_year
      puts "Invalid search range"
    else
      temp = books.select do |book|
        book[:year] >= strt_year && book[:year] <= end_year
      end
      if temp.empty?
        puts "No book found in this range (#{strt_year} - #{end_year})"
      else
        temp1 = temp.sort_by { |book| book[:year] }
        temp1.each_with_index do |book , idx|
          puts " #{idx + 1}: #{book[:name]} by #{book[:author]} in #{book[:year]}"
        end
      end
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
  puts "9. Books between years"
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
    when 9
        books_btw_years(books)
    else
        puts "invalid choice please enter a valid option"
    end
end

=begin
1. Add Book
2. List Books
3. Search Book
4. Update Book
5. Delete Book
6. Exit
7. List All Books
8. dev sats
9. Books between years
Enter your choice: 4
Enter the book name to update: harry POTTER
Enter the book new name: hArRy PoTtEr
Rename Harry Potter --> hArRy PoTtEr(y/n)
y
Enter the author new name: jk
Enter the new publication year: 2000
Book updated successfully
Library Management System
1. Add Book
2. List Books
3. Search Book
4. Update Book
5. Delete Book
6. Exit
7. List All Books
8. dev sats
9. Books between years
Enter your choice: 4
Enter the book name to update: harry potter
Enter the book new name: harry
Rename hArRy PoTtEr --> harry(y/n)
n
Update cancelled
Library Management System
1. Add Book
2. List Books
3. Search Book
4. Update Book
5. Delete Book
6. Exit
7. List All Books
8. dev sats
9. Books between years
Enter your choice: 7
Listing all books
 To Kill a Mockingbird by Harper Lee in 1960
 The Great Gatsby by F. Scott Fitzgerald in 1925
 hArRy PoTtEr by jk in 2000
 The Da Vinci Code by Dan Brown in 2003
 The Hunger Games by Suzanne Collins in 2008
 Project Hail Mary by Andy Weir in 2021
 The Alchemist by Paulo Coelho in 1988
Library Management System
1. Add Book
2. List Books
3. Search Book
4. Update Book
5. Delete Book
6. Exit
7. List All Books
8. dev sats
9. Books between years
Enter your choice: 6
exiting Good bye !
=end

