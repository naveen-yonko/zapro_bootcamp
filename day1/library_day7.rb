def show_menu
  puts "Library Management System"
  puts "1. Add Book"
  puts "2. List Books"
  puts "3. Search Book"
  puts "4. Update Book"
  puts "5. Delete Book"
  puts "6. Exit"
  puts "7. dev stats"
  puts "8. Books between years"
  puts "9. states"
  print "Enter your choice: "
end

def validate_input(value, field_name)
    if value.strip.empty?
        puts "#{field_name} cannot be blank."
        return false
    end
    true
end

class Book
    attr_accessor :name, :author, :year, :genre

    def initialize(name, author, year, genre)
        @name = name
        @author = author
        @year = year
        @genre = genre
    end

    def to_s
        "#{@name} by #{@author} in #{@year} (#{@genre})"
    end
    def age 
        cur_year = Time.now.year
        return cur_year - @year
    end
    def recent?
        return Time.now.year - @year <= 5 
    end

end

class Library
    attr_accessor :books
    def initialize
        @books = []
    end


    def add_book(name, author, year, genre)
        @books.push(Book.new(name, author, year, genre))
    end

    def list(limit = nil)
        if limit
            @books.first(limit).each { |book| puts "#{book}  #{book.age}" }
        else
            @books.each { |book| puts "#{book}  #{book.age}" }
        end
    end


    def find(name)
        @books.find { |book| book.name.downcase.include?(name.downcase) }
    end


    def update_book(name)
        find_book = find(name)
        if find_book
            puts "Book found: #{find_book}"
            print "Enter new name: "
            n_name = gets.chomp.strip
            return if !validate_input(n_name, "Book name")
            
            puts "Rename #{find_book.name} --> #{n_name}(y/n)"
            reply = gets.chomp.downcase.strip
            if reply != 'y'
                puts "Update cancelled"
                return
            else
                find_book.name = n_name
            end
            
            print "Enter new author: "
            n_author = gets.chomp.strip
            return if !validate_input(n_author, "Author name")
            find_book.author = n_author

            print "Enter new year: "
            n_year = gets.chomp.to_i
            find_book.year = n_year
            puts "Book updated successfully."
        else
            puts "Book not found."
        end
    end

    def delete
        print "Enter the book name to be delete: "
          name = gets.chomp.downcase.strip
          return if !validate_input(name, "Book name")
          temp = @books.reject! { |book| book.name.downcase == name }
          if temp.nil?
            puts "Book not found please enter a valid book name"
        else
            puts "Book deleted successfully"
        end
    end

    def dev_stats
        puts "Total number of books: #{@books.length}"
        temp = @books.count { |book|  book.recent? }
        puts "Books published recent: #{temp}"
        temp = @books.map { |book| book.author }
        uniq_auth = temp.uniq
        puts "Unique Auth List:"
        uniq_auth.each_with_index { |a,idx|  puts " #{idx + 1}: #{a}" }
    end

    def book_between_years
        print "Enter the start year: "
        strt_year = gets.chomp.to_i

        print "Enter the end year: "
        end_year = gets.chomp.to_i
        
        if strt_year > end_year
          puts "Invalid search range"
        
        else
            temp = @books.select{ |book| book.year >= strt_year && book.year <= end_year}
            
            if temp.empty?
                puts "No book found in this range (#{strt_year} - #{end_year})"
            else
                temp1 = temp.sort_by { |book| book.year }
                temp1.each_with_index { |book , idx| puts " #{idx + 1}: #{book.name} by #{book.author} in #{book.year}"}
            end
        end
    end

    def states
        if @books.empty?
            return { total: 0, by_genre: { }, average_year: 0 }
        else
            total = @books.length
            #by_genre = @books.group_by { |book| book.genre }
            by_genre = @books.map { |book| book.genre }.tally
            tot_year = @books.reduce(0) { |tot_year, elmt| tot_year + elmt.year }
            average_year = (tot_year / total).round
            return { total: total, by_genre: by_genre, average_year: average_year }

        end
    end
end

library = Library.new
library.add_book("The Hobbit", "J.R.R. Tolkien", 1937, "Fiction")
library.add_book("Harry Potter", "J.K. Rowling", 2001, "Fiction")
library.add_book("The Great Gatsby", "F. Scott Fitzgerald", 2023, "Fiction")
library.add_book("Ruby Guide", "Dev-Team", 2025, "Technical")

loop do
    show_menu
    choice = gets.chomp.to_i

    case choice
    when 1
        print "Enter book name: "
        name = gets.chomp.strip
        next if !validate_input(name, "Book name") #next = continue in java

        print "Enter author name: "
        author = gets.chomp.strip
        next if !validate_input(author, "Author name")

        print "Enter publication year: "
        year = gets.chomp.to_i

        print "Enter genre: "
        genre = gets.chomp.strip
        if genre.empty?
            genre = "Uncategorized"
        end

        library.add_book(name, author, year, genre)
        puts "Book added successfully."
    when 2
        puts "Listing Books Enter number to filter:"
        filter = gets.chomp.to_i
        if filter > 0
            library.list(filter)
        else
            library.list()
        end

    when 3
        print "Enter book name to search: "
        name = gets.chomp.strip
        next if !validate_input(name, "Book name")
        temp_book = library.find(name)
        if temp_book
            puts "Book found: #{temp_book}"
        else
            puts "Book not found."
        end
    when 4
        print "Enter book name to update: "
        name = gets.chomp.strip
        return if !validate_input(name, "Book name")
        library.update_book(name)
    when 5
        library.delete
    when 6
        puts "Exiting Goodbye!"
        break
    when 7
        library.dev_stats
    when 8
        library.book_between_years
    when 9
        report = library.states
        puts "->Total Books: #{report[:total]}"
        puts "->Books by Genre:"
        report[:by_genre].each { |genre, count| puts "  *  #{genre}: #{count}" }
        puts "->Average Publication Year: #{report[:average_year]}"
    else
        puts "Invalid choice. Please try again."
    end

    puts "\n"
end