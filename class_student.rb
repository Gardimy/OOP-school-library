class Student < Person 
  def initialize(age, classroom, name = "Unknown", parent_permission = true)  
    super(age, name: name, parent_permission: parent_permission)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end

  def play_hooky
    "¯\\(ツ)/¯"
  end

  def classroom=(classroom)
    if @classroom != classroom
      @classroom.students.delete(self) if @classroom
      @classroom = classroom
      classroom.students.push(self) unless classroom.students.include?(self)
    end
  end
end
