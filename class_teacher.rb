require_relative 'class_person'

class Teacher < Person
  def initialize(id, age, specialization, name = "Unknown", parent_permission = true)
    super(id, age, name, parent_permission)
    @specialization = specialization
  end

  # Override method can_use_services?
  def can_use_services?
    true
  end
end

teacher = Teacher.new(4, 32, "Mathematics", "Mr. Smith")

puts teacher.name          # Output: Mr. Smith
puts teacher.age           # Output: 32
puts teacher.specialization  # Output: Mathematics
puts teacher.can_use_services?  # Output: true (overridden)
