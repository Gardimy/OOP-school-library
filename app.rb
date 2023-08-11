# Load necessary files
require_relative 'class_book'
require_relative 'class_person'
require_relative 'class_rental'

# Initialize empty arrays to store books and people
books = []
people = []

# Method to list all books
def list_books(books)
  puts "List of Books:"
  books.each do |book|
    puts "Title: #{book.title}, Author: #{book.author}"
  end
  puts "\n"
end

# Method to list all people
def list_people(people)
  puts "List of People:"
  people.each do |person|
    puts "ID: #{person.id}, Name: #{person.name}, Age: #{person.age}"
  end
  puts "\n"
end

# Method to create a person
def create_person(age, name, parent_permission)
  person = Person.new(age, name, parent_permission: parent_permission)
  people << person
  puts "Person created with ID: #{person.id}\n\n"
end

# Method to create a book
def create_book(title, author)
  book = Book.new(title, author)
  books << book
  puts "Book created with title: #{book.title}\n\n"
end

# Method to create a rental
def create_rental(person_id, book_title, rental_date)
  person = people.find { |p| p.id == person_id }
  book = books.find { |b| b.title == book_title }

  if person && book
    rental = person.add_rental(book, rental_date)
    puts "Rental created for person #{person.name} with book #{book.title} on #{rental.date}\n\n"
  else
    puts "Person or book not found.\n\n"
  end
end

# Method to list all rentals for a given person id
def list_rentals_for_person(person_id)
  person = people.find { |p| p.id == person_id }
  
  if person
    puts "Rentals for #{person.name}:"
    person.rentals.each do |rental|
      puts "Book: #{rental.book.title}, Date: #{rental.date}"
    end
    puts "\n"
  else
    puts "Person not found.\n\n"
  end
end
