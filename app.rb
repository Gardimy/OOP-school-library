require_relative 'class_person'
require_relative 'class_book'
require_relative 'class_student'
require_relative 'class_classroom'
require_relative 'class_teacher'
require_relative 'class_rental'
require 'json'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []

    load_data
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
      create_student
    when 'teacher'
      create_teacher
    else
      puts 'Invalid person type.'
    end
  end

  def create_student
    puts 'Enter name:'
    name = gets.chomp

    puts 'Enter age:'
    age = gets.chomp.to_i

    puts 'Enter classroom:'
    classroom_name = gets.chomp
    classroom = Classroom.new(classroom_name)

    student = Student.new(age, classroom, name)
    @people.push(student)
    puts 'Student created!'
  end

  def create_teacher
    puts 'Enter name:'
    name = gets.chomp

    puts 'Enter age:'
    age = gets.chomp.to_i

    puts 'Enter specialization:'
    specialization = gets.chomp

    teacher = Teacher.new(age, specialization, name)
    @people.push(teacher)
    puts 'Teacher created!'
  end

  def create_book
    puts 'Enter title:'
    title = gets.chomp

    puts 'Enter author:'
    author = gets.chomp

    book = Book.new(title, author)
    @books.push(book)
    puts 'Book created!'
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

  def process(choice)
    case choice
    when 1
      list_books
    when 2
      list_people
    when 3
      create_person
    when 4
      create_book
    when 5
      create_rental
    when 6
      list_rentals_for_person
    when 7
      return :quit # Exit the loop
    else
      puts 'Invalid choice. Please select a valid option.'
    end
    :continue
  end

  def save_data
    books_data = @books.map { |book| { title: book.title, author: book.author } }
    people_data = @people.map do |person|
      data = { name: person.name, age: person.age }
      if person.is_a?(Student)
        data[:type] = 'student'
        data[:classroom] = person.classroom.label
      elsif person.is_a?(Teacher)
        data[:type] = 'teacher'
        data[:specialization] = person.specialization
      end
      data
    end
    rentals_data = @rentals.map do |rental|
      {
        person_index: @people.index(rental.person),
        book_index: @books.index(rental.book),
        date: rental.date
      }
    end

    File.write('books.json', books_data.to_json)
    File.write('people.json', people_data.to_json)
    File.write('rentals.json', rentals_data.to_json)
  end

  def load_data
    load_books
    load_people
    load_rentals
  rescue Errno::ENOENT => e
    puts "Error loading data: #{e.message}"
  end

  def load_books
    return unless File.exist?('books.json')

    books_data = JSON.parse(File.read('books.json'))
    @books = books_data.map { |data| Book.new(data['title'], data['author']) }
  end

  def load_people
    return unless File.exist?('people.json')

    people_data = JSON.parse(File.read('people.json'))
    people_data.each do |data|
      if data['type'] == 'student'
        classroom = Classroom.new(data['classroom'])
        student = Student.new(data['age'], classroom, data['name'])
        @people.push(student)
      elsif data['type'] == 'teacher'
        teacher = Teacher.new(data['age'], data['specialization'], data['name'])
        @people.push(teacher)
      end
    end
  end

  def load_rentals
    return unless File.exist?('rentals.json')

    rentals_data = JSON.parse(File.read('rentals.json'))
    rentals_data.each do |data|
      person = @people[data['person_index']]
      book = @books[data['book_index']]
      rental = person.add_rental(book, data['date'])
      @rentals.push(rental)
    end
  end

  def run
    loop do
      display_options
      print 'Select an option: '
      choice = gets.chomp.to_i

      result = process(choice)
      break if result == :quit # Exit the loop
      save_data
    end

    puts 'Exiting the application. Goodbye!'
  end
end

app = App.new
app.run
