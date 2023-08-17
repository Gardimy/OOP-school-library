require_relative 'class_person'

class Teacher < Person
  attr_reader :specialization

  def initialize(age, specialization, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end

  def self.create_teacher(people)
    puts 'Enter name:'
    name = gets.chomp

    puts 'Enter age:'
    age = gets.chomp.to_i

    puts 'Enter specialization:'
    specialization = gets.chomp

    teacher = Teacher.new(age, specialization, name)
    people.push(teacher)
    puts 'Teacher created!'
  end
end
