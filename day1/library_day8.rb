def validate_input(value, field_name)
    if value.strip.empty?
        puts "#{field_name} cannot be blank."
        return false
    end
    true
end

module Displayable

    def display
        puts "Title  : #{name}"
        puts "Author : #{author}"
        puts "Year   : #{year}"
        puts "Genre  : #{genre}"
        puts "-" * 30
    end

    def to_s
        "#{name} by #{author} in #{year} (#{genre})"
    end
end

module Exportable
    def to_csv_row
        attris= [name, author, year, genre]
        tmp = attris.map do |attr|
            if attr.to_s.include?(",")
                "\"#{attr}\""
            else
                attr.to_s
            end
        end
        tmp.join(",")
    end
end 

class Book
    attr_accessor :name, :author, :year, :genre
    include Displayable
    include Exportable

    def initialize(name, author, year, genre)
        @name = name
        @author = author
        @year = year
        @genre = genre
    end

    def age 
        cur_year = Time.now.year
        return cur_year - @year
    end
    def recent?
        return Time.now.year - @year <= 5 
    end
    def <=>(otherobj)
        year <=> otherobj.year #@ no need coz we have gettter
    end

end

module Searchable

    def list(array, limit = nil)
        if limit
            array.first(limit).each { |arr| puts "#{arr}" }
        else
            array.each { |arr| puts "#{arr}" }
        end
    end

    def finder(array,var,name)
         array.select { |book| book.send(var).downcase.include?(name.downcase) }
    end 
end

module LibraryMethods
    #no need @ as we defined getter in lib so no need to wory
    def add_book(name, author, year, genre)
        books.push(Book.new(name, author, year, genre))
    end
    
    def update_book(name)
        find_book = finder(books, :name, name)
        if find_book.any?
            puts "Book found"
            find_book.first.display
            print "Enter new name: "
            n_name = gets.chomp.strip
            return if !validate_input(n_name, "Book name")
            
            puts "Rename #{find_book.first.name} --> #{n_name}(y/n)"
            reply = gets.chomp.downcase.strip
            if reply != 'y'
                puts "Update cancelled"
                return
            else
                find_book.first.name = n_name
            end
            
            print "Enter new author: "
            n_author = gets.chomp.strip
            return if !validate_input(n_author, "Author name")
            find_book.first.author = n_author

            print "Enter new year: "
            n_year = gets.chomp.to_i
            find_book.first.year = n_year
            puts "Book updated successfully."
        else
            puts "Book not found."
        end
    end

    def delete
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

    def dev_stats
        puts "Total number of books: #{books.length}"
        temp = books.count { |book|  book.recent? }
        puts "Books published recent: #{temp}"
        temp = books.map { |book| book.author }
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
            temp = books.select{ |book| book.year >= strt_year && book.year <= end_year}
            
            if temp.empty?
                puts "No book found in this range (#{strt_year} - #{end_year})"
            else
                temp1 = temp.sort_by { |book| book.year }
                temp1.each_with_index { |book , idx| puts " #{idx + 1}: #{book.name} by #{book.author} in #{book.year}"}
            end
        end
    end

    def states
        if books.empty?
            return { total: 0, by_genre: { }, average_year: 0 }
        else
            total = books.length
            #by_genre = books.group_by { |book| book.genre }
            by_genre = books.map { |book| book.genre }.tally
            tot_year = books.reduce(0) { |tot_year, elmt| tot_year + elmt.year }
            average_year = (tot_year / total).round
            return { total: total, by_genre: by_genre, average_year: average_year }

        end
    end
    def exporter(name)
        temp_book = finder(books,:name ,name)
        if temp_book.any?
            puts "Books found by #{name}:"
            temp_book.each { |book| puts book.to_csv_row }
        else
            puts "No books found by #{name}."
        end
    end

end


class Library
    attr_accessor :books

    include Searchable
    include LibraryMethods
    def initialize
        @books = []
    end

    def books
        @books
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
  puts "7. dev stats"
  puts "8. Books between years"
  puts "9. states"
  puts "10. Export to CSV"
  puts "11. Search by author"
  puts "12. Display sorted by year"
  print "Enter your choice: "
end

library = Library.new
library.add_book("The Hobbit", "J.R.R. Tolkien", 1937, "Fiction")
library.add_book("HarryPotter", "J.K, Rowling", 2001, "Fiction")
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
            library.list(library.books,filter)
        else
            library.list(library.books)
        end

    when 3
        print "Enter book name to search: "
        name = gets.chomp.strip
        next if !validate_input(name, "Book name")
        temp_book = library.finder(library.books,:name ,name)
        if temp_book.any?
            puts "Books found by #{name}:"
            temp_book.each { |book| puts book }
        else
            puts "No books found by #{name}."
        end
    when 4
        print "Enter book name to update: "
        name = gets.chomp.strip
        next if !validate_input(name, "Book name")
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
    when 10
        print "Enter book name to search and get csv : "
        name = gets.chomp.strip
        next if !validate_input(name, "Book name")
        library.exporter(name)
    when 11
        print "Enter author name to search: "
        name = gets.chomp.strip
        next if !validate_input(name, "Author name")
        temp_book = library.finder(library.books,:author ,name)
        if temp_book.any?
            puts "Books found by #{name}:"
            temp_book.each { |book| puts book }
        else
            puts "No books found by #{name}."
        end
    when 12
        library.books.sort.each { |book| puts book }
    else
        puts "Invalid choice. Please try again."
    end

    puts "\n"
end

class Movie
  attr_accessor :name, :director, :year, :genre

  def initialize(name, director, year, genre)
    @name = name
    @director = director
    @year = year
    @genre = genre
  end

  def to_s
    " #{name} by #{director} in (#{year}) [#{genre}]"
  end
end

 class Theatre
    attr_accessor :movies

    include Searchable

    def initialize
        @movies = []
    end

    def movies
        @movies
    end

    def add_movie(name, director, year, genre)
        movies.push(Movie.new(name, director, year, genre))
    end
end

theatre = Theatre.new
theatre.add_movie("Inception", "Christopher Nolan", 2010, "Sci-Fi")
theatre.add_movie("The Matrix", "Wachowskis", 1999, "Action")
theatre.add_movie("Interstellar", "Christopher Nolan", 2014, "Sci-Fi")

puts "==> Searching movie by cristo':"
nolan_movies = theatre.finder(theatre.movies, :director, "Christopher Nolan")
nolan_movies.each { |movie| puts movie }

puts "Displaying all movies:"
theatre.list(theatre.movies)