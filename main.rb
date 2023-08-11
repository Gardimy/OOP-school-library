require_relative 'class_book'
require_relative 'class_person'
require_relative 'class_rental'
require_relative 'app'

loop do
  puts "Menu:"
  puts "1 - List all books"
  puts "2 - List all people"
  puts "3 - Create a person"
  puts "4 - Create a book"
  puts "5 - Create a rental"
  puts "6 - List all rentals for a given person id"
  puts "7 - Exit"
  print "Enter your choice: "
  choice = gets.chomp.to_i

  case choice
  when 1
    list_books(books)
  when 2
    list_people(people)
  when 3
    print "Enter age: "
    age = gets.chomp.to_i
    print "Enter name: "
    name = gets.chomp
    print "Does the person have parent permission? (true/false): "
    parent_permission = gets.chomp.downcase == 'true'
    create_person(age, name, parent_permission)
  when 4
    print "Enter book title: "
    title = gets.chomp
    print "Enter author: "
    author = gets.chomp
    create_book(title, author)
  when 5
    print "Enter person ID: "
    person_id = gets.chomp.to_i
    print "Enter book title: "
    book_title = gets.chomp
    print "Enter rental date: "
    rental_date = gets.chomp
    create_rental(person_id, book_title, rental_date)
  when 6
    print "Enter person ID: "
    person_id = gets.chomp.to_i
    list_rentals_for_person(person_id)
  when 7
    puts "Exiting the app. Goodbye!"
    break
  else
    puts "Invalid choice. Please select a valid option.\n\n"
  end
end
