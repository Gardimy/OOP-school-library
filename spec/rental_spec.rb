require 'date'
require_relative '../class_rental'
require_relative '../class_book'
require_relative '../class_person'

RSpec.describe Rental do
  describe '#initialize' do
    it 'creates a rental associated with a person and a book' do
      book = Book.new('Sample Title', 'Sample Author')
      person = Person.new(25)
      rental = Rental.new(Date.today, book, person)

      expect(rental.date).to eq(Date.today)
      expect(rental.book).to eq(book)
      expect(rental.person).to eq(person)
      expect(book.rentals).to include(rental)
      expect(person.rentals).to include(rental)
    end
  end
end
