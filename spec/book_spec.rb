require 'date'
require_relative '../class_book'
require_relative '../class_person'
require_relative '../class_rental'

RSpec.describe Book do
  describe '#add_rental' do
    it 'creates a rental and associates it with the book and person' do
      book = Book.new('Sample Title', 'Sample Author')
      person = Person.new(25)

      rental = book.add_rental(person, Date.today)

      expect(rental.book).to eq(book)
      expect(rental.person).to eq(person)
      expect(book.rentals).to include(rental)
      expect(person.rentals).to include(rental)
    end
  end
end
