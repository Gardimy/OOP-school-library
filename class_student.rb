require_relative 'class_person'

class Student < Person
  def initialize(id, age, classroom, name = "Unknown", parent_permission = true)
    super(id, age, name, parent_permission)
    @classroom = classroom
  end

  # Getter for @classroom
  def classroom
    @classroom
  end

  # Method specific to Student
  def play_hooky
    "¯\\(ツ)/¯"
  end
end

student = Student.new(3, 16, "Physics", "Danie")

puts student.name          # Output: Danie
puts student.age           # Output: 16
puts student.classroom     # Output: Physics
puts student.can_use_services?  # Output: true (parent_permission)
puts student.play_hooky    # Output: ¯\(ツ)/¯
