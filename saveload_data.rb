require 'json'

module SaveLoadData
  def save_books(books)
    books_data = books.map { |book| { title: book.title, author: book.author } }
    File.write('books.json', books_data.to_json)
  end

  def save_people(people)
    people_data = people.map do |person|
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
    File.write('people.json', people_data.to_json)
  end

  def save_rentals(people, books, rentals)
    rentals_data = rentals.map do |rental|
      {
        person_index: people.index(rental.person),
        book_index: books.index(rental.book),
        date: rental.date
      }
    end
    File.write('rentals.json', rentals_data.to_json)
  end

  def load_books
    return [] unless File.exist?('books.json')

    books_data = JSON.parse(File.read('books.json'))
    books_data.map { |data| Book.new(data['title'], data['author']) }
  end

  def load_people(classroom_class)
    return [] unless File.exist?('people.json')

    people_data = JSON.parse(File.read('people.json'))
    people_data.map do |data|
      if data['type'] == 'student'
        classroom = classroom_class.new(data['classroom'])
        Student.new(data['age'], classroom, data['name'])
      elsif data['type'] == 'teacher'
        Teacher.new(data['age'], data['specialization'], data['name'])
      end
    end
  end

  def load_rentals(people, books)
    return [] unless File.exist?('rentals.json')

    rentals_data = JSON.parse(File.read('rentals.json'))
    rentals_data.map do |data|
      person = people[data['person_index']]
      book = books[data['book_index']]
      person.add_rental(book, data['date'])
    end
  end
end
