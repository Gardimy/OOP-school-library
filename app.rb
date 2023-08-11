require_relative 'class_book'
require_relative 'class_person'
require_relative 'class_rental'
require_relative 'class_teacher'
require_relative 'class_classroom'

# Initialize empty arrays to store books, people, and rentals
books = []
people = []
rentals = []

# Define methods to perform the desired actions

# Method to list all books
def list_all_books(books)
  puts "List of all books:"
  books.each do |book|
    puts "Title: #{book.title}, Author: #{book.author}"
  end
end

# Method to list all people (teachers and students)
def list_all_people(people)
  puts "List of all people:"
  people.each do |person|
    puts "ID: #{person.id}, Name: #{person.name}, Age: #{person.age}"
  end
end

# Method to create a person (teacher or student)
def create_person(people)
  puts "Enter person's name:"
  name = gets.chomp
  puts "Enter person's age:"
  age = gets.chomp.to_i
  puts "Is this person a teacher? (y/n)"
  is_teacher = gets.chomp.downcase == 'y'
  
  if is_teacher
    puts "Enter teacher's specialization:"
    specialization = gets.chomp
    person = Teacher.new(age, specialization, name)
  else
    person = Person.new(age, name)
  end
  
  people << person
  puts "Person created successfully!"
end

# Method to create a book
def create_book(books)
  puts "Enter book's title:"
  title = gets.chomp
  puts "Enter book's author:"
  author = gets.chomp
  book = Book.new(title, author)
  books << book
  puts "Book created successfully!"
end

# Method to create a rental
def create_rental(rentals, books, people)
  puts "Enter person's ID:"
  person_id = gets.chomp.to_i
  person = people.find { |p| p.id == person_id }
  
  if person.nil?
    puts "Person with ID #{person_id} not found."
    return
  end
  
  puts "Enter book's title:"
  book_title = gets.chomp
  book = books.find { |b| b.title == book_title }
  
  if book.nil?
    puts "Book with title '#{book_title}' not found."
    return
  end
  
  puts "Enter rental date (YYYY-MM-DD):"
  date = gets.chomp
  
  rental = person.add_rental(book, date)
  rentals << rental
  puts "Rental created successfully!"
end

# Method to list all rentals for a given person id
def list_rentals_for_person(people)
  puts "Enter person's ID:"
  person_id = gets.chomp.to_i
  person = people.find { |p| p.id == person_id }
  
  if person.nil?
    puts "Person with ID #{person_id} not found."
    return
  end
  
  puts "Rentals for #{person.name}:"
  person.rentals.each do |rental|
    puts "Book: #{rental.book.title}, Date: #{rental.date}"
  end
end
