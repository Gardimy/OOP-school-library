require_relative 'app'

# Method to present the user with options
def main_menu
  puts "Library Management System"
  puts "1. List all books"
  puts "2. List all people"
  puts "3. Create a person"
  puts "4. Create a book"
  puts "5. Create a rental"
  puts "6. List rentals for a person"
  puts "7. Quit"
end

# Main entry point of the application
def main
  loop do
    main_menu
    choice = gets.chomp.to_i
    
    case choice
    when 1
      list_all_books(books)
    when 2
      list_all_people(people)
    when 3
      create_person(people)
    when 4
      create_book(books)
    when 5
      create_rental(rentals, books, people)
    when 6
      list_rentals_for_person(people)
    when 7
      puts "Exiting the application."
      break
    else
      puts "Invalid choice. Please select a valid option."
    end
  end
end

# Call the main method to start the application
main
