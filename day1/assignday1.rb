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

loop do
    puts "library management system (hidden menu spanish)"
    puts "1. add book"
    puts "2. list book"
    puts "3. search book"
    puts "4. update book"
    puts "5. delete book"
    puts "6. exit"
    print "enter your choice: "
    choice = gets.chomp
    case choice
    when "0"
        spanishmenu
    when "1"
        puts "adding book"
    when "2"
        puts "listing book"
    when "3"
        puts "searching book"
    when "4"
        puts "updating book"
    when "5"
        puts "deleting book"
    when "6"
        puts "exiting Good bye !"
        break
    else
        puts "invalid choice please enter a valid option"
    end
end

=begin
~~~~~~~output~~~~~~~
library management system (hidden menu spanish)
1. add book
2. list book
3. search book
4. update book
5. delete book
6. exit
enter your choice: 1
adding book
library management system (hidden menu spanish)
1. add book
2. list book
3. search book
4. update book
5. delete book
6. exit
enter your choice: 
invalid choice please enter a valid option
library management system (hidden menu spanish)
1. add book
2. list book
3. search book
4. update book
5. delete book
6. exit
enter your choice: 2
listing book
library management system (hidden menu spanish)
1. add book
2. list book
3. search book
4. update book
5. delete book
6. exit
enter your choice: 4
updating book
library management system (hidden menu spanish)
1. add book
2. list book
3. search book
4. update book
5. delete book
6. exit
enter your choice: 0
sistema de gestion de biblioteca (menu oculto español)
1. agregar libro
2. listar libro
3. buscar libro
4. actualizar libro
5. eliminar libro
6. salir
Press Enter to return to English menu

library management system (hidden menu spanish)
1. add book
2. list book
3. search book
4. update book
5. delete book
6. exit
enter your choice: 4
updating book
library management system (hidden menu spanish)
1. add book
2. list book
3. search book
4. update book
5. delete book
6. exit
enter your choice: dfkjldhfkjs
invalid choice please enter a valid option
library management system (hidden menu spanish)
1. add book
2. list book
3. search book
4. update book
5. delete book
6. exit
enter your choice: 6
exiting Good bye !

=end