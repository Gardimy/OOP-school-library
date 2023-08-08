require_relative 'class_person'

class Teacher < Person
  attr_reader :specialization

  def initialize(id, age, specialization, name = 'Unknown', parent_permission: true)
    super(id, age, name: name, parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end

teacher = Teacher.new(4, 32, 'Mathematics', 'Mr. Smith')

puts teacher.name
puts teacher.age
puts teacher.specialization
puts teacher.can_use_services?
