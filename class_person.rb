class Person
  attr_accessor :name, :rentals

  def initialize(name)
    @name = name
    @rentals = []
  end
end
