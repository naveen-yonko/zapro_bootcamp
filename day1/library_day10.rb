require 'csv'
require 'fileutils'

class BookNotFoundError < StandardError
    def initialize(title)
        super("Book not found: #{title}")
    end
end

class InvalidInputError < StandardError
end

def validate_input(value, field_name)
    if value.strip.empty?
        puts "#{field_name} cannot be blank."
        return false
    end
    true
end

module Displayable
    def to_s
        "#{name} by #{author} in #{year} (#{genre})"
    end
end

module Exportable
    def to_csv_row
        attris= [name, author, year, genre, type]
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
    attr_accessor :name, :author, :year, :genre , :type
    include Displayable
    include Exportable
    include Comparable

    def initialize(name, author, year, genre,type = "Physical")
        @name = name
        @author = author
        @year = year
        @genre = genre
        @type = type
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

class Digital_Book < Book
    attr_accessor :url
    def initialize(name, author, year,genre, url)
        super(name, author, year, genre,"Digital")
        @url = url
    end
    def to_s
        super() + " [URL: #{url}]"
    end
end 

class Audio_book < Book
    attr_accessor :duration
    def initialize(name, author, year, genre, duration)
        super(name, author, year, genre,"Audio")
        @duration = duration
    end
    def to_s
            hrs = duration / 60
            mins = duration % 60
            super() + " [Duration: #{hrs}h #{mins}m]"
    end
end

module Searchable

    def list( limit = nil)
        if limit
            all_books.first(limit).each { |arr| puts "#{arr}" }
        else
            all_books.each { |arr| puts "#{arr}" }
        end
    end

    def finder(var,name)
         all_books.select { |book| book.send(var).downcase.include?(name.downcase) }
    end 
end


module LibraryMethods
    #no need @ as we defined getter in lib so no need to wory
    def add_book(name, author, year, genre,url: nil, duration: nil)
        if url
            books.push(Digital_Book.new(name, author, year, genre, url))
        elsif duration
            books.push(Audio_book.new(name, author, year, genre, duration))
        else
            books.push(Book.new(name, author, year, genre))
        end
    end

    
    def update_book(name)
        find_book = finder(:name, name)
        if find_book.any?
            puts "Book found #{find_book.first.to_s}"
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
            
            print "Enter new genre: "
            n_genre = gets.chomp.strip
            return if !validate_input(n_genre, "Genre")
            find_book.first.genre = n_genre

            if find_book.first.is_a?(Digital_Book)
                print "Enter new URL: "
                n_url = gets.chomp.strip
                return if !validate_input(n_url, "URL")
                find_book.first.url = n_url
            elsif find_book.first.is_a?(Audio_book)
                print "Enter new duration in min : "
                n_duration = gets.chomp.to_i
                find_book.first.duration = n_duration
            end
            puts "Book updated successfully."
        else
            puts "Book not found."
        end
    end

    def delete
        print "Enter the book name to be delete: "
          name = gets.chomp.downcase.strip
          return if !validate_input(name, "Book name")
          temp = all_books.reject! { |book| book.name.downcase == name }
          if temp.nil?
            puts "Book not found please enter a valid book name"
        else
            puts "Book deleted successfully"
        end
    end

    def dev_stats
        puts "Total number of books: #{all_books.length}"
        temp = all_books.count { |book|  book.recent? }
        puts "Books published recent: #{temp}"
        temp = all_books.map { |book| book.author }
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
            temp = all_books.select{ |book| book.year >= strt_year && book.year <= end_year}
            
            if temp.empty?
                puts "No book found in this range (#{strt_year} - #{end_year})"
            else
                temp1 = temp.sort_by { |book| book.year }
                temp1.each_with_index { |book , idx| puts " #{idx + 1}: #{book.name} by #{book.author} in #{book.year}"}
            end
        end
    end

    def states
        if all_books.empty?
            return { total: 0, by_genre: { }, average_year: 0 }
        else
            total = all_books.length
            by_genre = all_books.map { |book| book.genre }.tally
            tot_year = all_books.reduce(0) { |tot_year, elmt| tot_year + elmt.year }
            average_year = (tot_year / total).round
            return { total: total, by_genre: by_genre, average_year: average_year }

        end
    end
    def exporter(name)
        temp_book = finder(:name, name)
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

    def all_books
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
  puts "13. Add Digital Book"
  puts "14. Add Audio Book"
  print "Enter your choice: "
end

def get_ip
    print "Enter book name: "
    name = gets.chomp.strip
    return nil if !validate_input(name, "Book name") #next = continue in java

    print "Enter author name: "
    author = gets.chomp.strip
    return nil if !validate_input(author, "Author name")

    print "Enter publication year: "
    year = gets.chomp.to_i
    raise InvalidInputError, "Publication year must be a valid number" if year <= 0#as to_i return 0 if we type non num

    print "Enter genre: "
    genre = gets.chomp.strip
    if genre.empty?
        genre = "Uncategorized"
    end
    return [name, author, year, genre]
end

library = Library.new

def load_library(library)
    if File.exist?("books.csv")
        CSV.foreach("books.csv", headers: true) do |row|
            case row["type"]
            when "Digital"
                library.add_book(row["name"], row["author"], row["year"].to_i, row["genre"], url: row["url"])
            when "Audio"
                library.add_book(row["name"], row["author"], row["year"].to_i, row["genre"], duration: row["duration"].to_i)
            else
                library.add_book(row["name"], row["author"], row["year"].to_i, row["genre"])
            end
        end
        puts "Library loaded with size #{library.all_books.size}."
    else
        raise StandardError, "books.csv file not found ."
    end
end

def save_library(library)
    CSV.open("books.csv", "w") do |csv|
        csv << ["name", "author", "year", "genre", "type", "url", "duration"]
        library.all_books.each do |book|
            if book.is_a?(Digital_Book)
                csv << [book.name, book.author, book.year, book.genre, "Digital", book.url, nil]
            elsif book.is_a?(Audio_book)
                csv << [book.name, book.author, book.year, book.genre, "Audio", nil, book.duration]
            else
                csv << [book.name, book.author, book.year, book.genre, "Physical", nil, nil]
            end
        end
    end
    puts "Library saved in books.csv."
end

def backup_library
  if File.exist?("books.csv")
    FileUtils.cp("books.csv", "books_backup.csv")
    puts "Backup created: books_backup.csv"
  end
end


load_library(library)

begin
    loop do
    show_menu
    choice = gets.chomp.to_i

    case choice
    when 1
        name, author, year, genre = get_ip
        if name.nil? || author.nil? || year.nil? || genre.nil?
            puts "Invalid input. Book not added."
            next
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

        temp_book = library.finder(:name ,name)
        if temp_book.any?
            puts "Books found by #{name}:"
            temp_book.each { |book| puts book }
        else
            puts "No books found by #{name}."
            raise BookNotFoundError.new(name)
        end

    when 4
        print "Enter book name to update: "
        name = gets.chomp.strip
        next if !validate_input(name, "Book name")
        library.update_book(name)

    when 5
        library.delete
    when 6
        backup_library
        save_library(library)
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
        temp_book = library.finder(:author ,name)
        if temp_book.any?
            puts "Books found by #{name}:"
            temp_book.each { |book| puts book }
        else
            puts "No books found by #{name}."
        end

    when 12
        library.books.sort.each { |book| puts book }
    when 13
        name, author, year, genre = get_ip
        if name.nil? || author.nil? || year.nil? || genre.nil?
            puts "Invalid input. Digital book not added."
            next
        end

        print "Enter URL: "
        url = gets.chomp.strip
        next if !validate_input(url, "URL")

        library.add_book(name, author, year, genre, url:url)
        puts "Book added successfully."

    when 14
        name, author, year, genre = get_ip
        if name.nil? || author.nil? || year.nil? || genre.nil?
            puts "Invalid input. Audio book not added."
            next
        end
        print "Enter duration in minutes: "
        duration = gets.chomp.to_i
        raise InvalidInputError, "Duration must be a valid +ve number" if duration <= 0

        library.add_book(name, author, year, genre, duration: duration)
        puts "Audio book added successfully."

    else
        puts "Invalid choice. Please try again."
    end
    puts "\n"
end

rescue BookNotFoundError => e
    puts "Book error: #{e.message}"
rescue InvalidInputError => e
    puts "Input Error: #{e.message}"
rescue StandardError => e
    puts "The error class: #{e.class}"
    puts "An error occurred: #{e.message}"
ensure
    puts "Session ended."
end
at_exit do
    save_library(library)
end