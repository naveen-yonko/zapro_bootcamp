books = []

class Book
    @@cnt = 0
    @count = 0
    attr_accessor :name, :author, :year

    class << self
        attr_accessor :count
    end
    
    def initialize(name, author, year)
        @name = name
        @author = author
        @year = year
        self.class.count += 1
        @@cnt += 1
    end
    def self.cnt
        @@cnt
    end

    def to_s
        "#{@name} by #{@author} in #{@year}"
    end
end

books.push(Book.new("The Hobbit", "J.R.R. Tolkien", 1937))
books.push(Book.new("Harry Potter", "J.K. Rowling", 2001))
books.push(Book.new("The Great Gatsby", "F. Scott Fitzgerald", 2023))
books.push(Book.new("To Kill a Mockingbird", "Harper Lee", 2024))


def contains(books)
    if books.empty?
        puts "Library is empty"
        return false 
    else
        return true
    end
end

def validate_input(value, field_name)
    if value.strip.empty?
        puts "#{field_name} cannot be blank."
        return false
    end
    true
end

def add_book(books)
  puts "Adding the book"

  print "Enter the book name: "
  name = gets.chomp.strip
  return if !validate_input(name, "Book name")

  print "Enter the author name: "
  author = gets.chomp.strip
  return if !validate_input(author, "Author name")
    

  print "Enter the publication year: "
  year = gets.chomp.to_i
  if year <= 0
    puts "Publication year must be a positive integer."
    return
  end

  #book = { name: name, author: author, year: year }
  book = Book.new(name, author, year)
  books.push(book)  #books << book we can also use this
  puts "Book added successfully"
end

def list_books(books)
    if contains(books)
        puts "Top 3 books"
        books.first(3).each { |book| puts book }
    end
end

def list_all_books(books)
    if contains(books)
        puts "Listing all books"
        books.each { |book| puts book }
    end
end

def search_book(books)
    if contains(books)
        print "Enter the book name to search: "
        name = gets.chomp.strip
        return if !validate_input(name, "Book name")

        find_book = books.find{ |book| book.name.downcase == name.downcase }

        if find_book
            puts "Book found: #{find_book}"
        else
            puts "Book not found."
        end
    end
end

def update_books(books)
    if contains(books)
        print "Enter the book name to update: "
        name = gets.chomp.strip
        return if !validate_input(name, "Book name")

        find_book = books.find{ |book| book.name.downcase == name.downcase }

        if find_book
            print "Enter the book new name: "
            n_name = gets.chomp.strip
            return if !validate_input(n_name, "Book name")

            puts "Rename #{find_book.name} --> #{n_name}(y/n)"
            reply = gets.chomp.downcase.strip
            if reply != 'y'
                puts "Update cancelled"
                return
            end

            print "Enter the author new name: "
            n_author = gets.chomp.strip
            return if !validate_input(n_author, "Author name")

            print "Enter the new publication year: "
            n_year = gets.chomp.to_i

            find_book.name = n_name
            find_book.author = n_author
            find_book.year = n_year

            puts "Book updated successfully: #{find_book}"

        else
            puts "Book not found."
        end
    end
end

def delete_book(books)
    if contains(books)
          print "Enter the book name to be delete: "
          name = gets.chomp.downcase.strip
          return if !validate_input(name, "Book name")
          temp = books.reject! { |book| book.name.downcase == name }
          if temp.nil?
            puts "Book not found please enter a valid book name"
        else
            puts "Book deleted successfully"
        end
    end
end

def dev_stats(books)
    if contains(books)
        puts "Total number of books: #{Book.count}"#we can also try @@cnt type also
        temp = books.count { |book|  book.year > 2000 }
        puts "Books published after 2000: #{temp}"
        temp = books.map { |book| book.author }
        uniq_auth = temp.uniq
        puts "Unique Auth List:"
        uniq_auth.each_with_index { |a,idx|  puts " #{idx + 1}: #{a}" }
    end
end

def books_btw_years(books)
    if contains(books)
        puts "Books between years"
        print "Enter the start year: "
        strt_year = gets.chomp.to_i
        print "Enter the end year: "
        end_year = gets.chomp.to_i
        if strt_year > end_year
          puts "Invalid search range"
        else
            temp = books.select{ |book| book.year >= strt_year && book.year <= end_year}
            if temp.empty?
                puts "No book found in this range (#{strt_year} - #{end_year})"
            else
                temp1 = temp.sort_by { |book| book.year }
                temp1.each_with_index { |book , idx| puts " #{idx + 1}: #{book.name} by #{book.author} in #{book.year}"}
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
        add_book(books)
    when 2
        list_books(books)
    when 3
        search_book(books)
    when 4
        update_books(books)
    when 5
        delete_book(books)
    when 6
        puts "exiting Good bye !"
        break
    when 7
        list_all_books(books)
    when 8
        dev_stats(books)
    when 9
        books_btw_years(books)
    else
        puts "invalid choice please enter a valid option"
    end
end
