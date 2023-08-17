require_relative 'class_person'
require_relative 'class_book'
require_relative 'class_student'
require_relative 'class_classroom'
require_relative 'class_teacher'
require_relative 'class_rental'
require_relative 'saveload_data'

class App
  include SaveLoadData

  def initialize
    @books = load_books
    @people = load_people(Classroom)
    @rentals = load_rentals(@people, @books)
  end

  def list_books
    @books.each_with_index do |book, index|
      puts "#{index + 1}. Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_people
    @people.each_with_index do |person, index|
      puts "#{index + 1}. Name: #{person.name}, Age: #{person.age}"
    end
  end

  def create_person
    puts 'Enter person type (student/teacher):'
    person_type = gets.chomp.downcase

    case person_type
    when 'student'
      Student.create_student(@people)
    when 'teacher'
      Teacher.create_teacher(@people)
    else
      puts 'Invalid person type.'
    end
  end

  def create_book
    Book.create_book(@books)
  end

  def create_rental
    puts 'Select a person by their index:'
    list_people
    person_index = gets.chomp.to_i - 1

    puts 'Select a book by its index:'
    list_books
    book_index = gets.chomp.to_i - 1

    puts 'Enter rental date (YYYY-MM-DD):'
    date = gets.chomp

    rental = @people[person_index].add_rental(@books[book_index], date)
    @rentals.push(rental)
    puts 'Rental created!'
  end

  def list_rentals_for_person
    puts 'Select a person by their index:'
    list_people
    person_index = gets.chomp.to_i - 1

    person = @people[person_index]
    puts "Rentals for #{person.name}:"
    person.rentals.each do |rental|
      puts "Date: #{rental.date}, Book: #{rental.book.title}"
    end
  end

  def display_options
    puts 'Options:'
    puts '1. List all books'
    puts '2. List all people'
    puts '3. Create a person'
    puts '4. Create a book'
    puts '5. Create a rental'
    puts '6. List rentals for a person'
    puts '7. Exit'
  end

  def valid_choice?(choice)
    (1..7).include?(choice)
  end

  def process(choice)
    case choice
    when 1 then list_books
    when 2 then list_people
    when 3 then create_person
    when 4 then create_book
    when 5 then create_rental
    when 6 then list_rentals_for_person
    else
      puts 'Invalid choice.'
    end
  end

  def run
    loop do
      display_options
      print 'Select an option: '
      choice = gets.chomp.to_i

      if valid_choice?(choice)
        process(choice)

        # Save data after each action
        save_books(@books)
        save_people(@people)
        save_rentals(@people, @books, @rentals)

        break if choice == 7
      else
        puts 'Invalid choice. Please select a valid option.'
      end
    end

    puts 'Exiting the application. Goodbye!'
  end
end

app = App.new
app.run
