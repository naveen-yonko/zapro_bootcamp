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
  puts "Top 3 books"
  books.first(3).each { |book| puts book[:name] +" by "+ book[:author] +" in "+ book[:year].to_s }#need to use .to_s as year is int
end 


def listallbooks(books)
  puts "Listing all books"
  books.each do |book|
    puts " #{book[:name]} by #{book[:author]} in #{book[:year]}"
  end
end

def searchbook(books)
  puts "Searching book"
  print "Enter the book name to search: "
  name = gets.chomp.downcase.strip
  books.each do |book|
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

loop do
    puts "library management system"
    puts "1. add book"
    puts "2. list book"
    puts "3. search book"
    puts "4. update book"
    puts "5. delete book"
    puts "6. exit"
    puts"7. list all books"
    print "enter your choice: "
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
    else
        puts "invalid choice please enter a valid option"
    end
end
