require_relative '../class_person'

RSpec.describe Person do
  describe '#can_use_services?' do
    it 'returns true if the person is of age' do
      person = Person.new(21)
      expect(person.can_use_services?).to eq(true)
    end

    it 'returns true if the person has parent permission' do
      person = Person.new(15, 'John', parent_permission: true)
      expect(person.can_use_services?).to eq(true)
    end

    it 'returns false if the person is underage and has no parent permission' do
      person = Person.new(16, 'Alice', parent_permission: false)
      expect(person.can_use_services?).to eq(false)
    end
  end
end
