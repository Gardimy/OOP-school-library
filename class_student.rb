class Student < Person
  attr_accessor :classroom

  def initialize(age, classroom, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end

  def self.create_student(people)
    puts 'Enter name:'
    name = gets.chomp

    puts 'Enter age:'
    age = gets.chomp.to_i

    puts 'Enter classroom:'
    classroom_name = gets.chomp
    classroom = Classroom.new(classroom_name)

    student = Student.new(age, classroom, name)
    people.push(student)
    puts 'Student created!'
  end
end
