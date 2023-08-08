class Person
  def initialize(id, age, name = "Unknown", parent_permission = true)
    @id = id
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  # Getters
  def id
    @id
  end

  def name
    @name
  end

  def age
    @age
  end

  # Setters
  def name=(new_name)
    @name = new_name
  end

  def age=(new_age)
    @age = new_age
  end

  # Private method
  private def of_age?
    @age >= 18
  end

  # Public method
  def can_use_services?
    of_age? || @parent_permission
  end
end

person1 = Person.new(1, 25, "Gardimy", false)
person2 = Person.new(2, 15, "Cassandra")

puts person1.can_use_services? # Output: true (of_age?)
puts person2.can_use_services? # Output: true (parent_permission)
