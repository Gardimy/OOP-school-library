require_relative 'class_teacher'

RSpec.describe Teacher do
  describe '#can_use_services?' do
    it 'always returns true for teachers' do
      teacher = Teacher.new(35, 'Math', 'Mr. Smith')
      expect(teacher.can_use_services?).to eq(true)
    end
  end
end
