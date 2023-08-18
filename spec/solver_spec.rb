require_relative '../solver_facto'

RSpec.describe Solver do
  before(:each) do
    @solver = Solver.new
  end

  describe '#factorial' do
    it 'returns 1 for factorial of 0' do
      expect(@solver.factorial(0)).to eq(1)
    end

    it 'returns the correct factorial for positive integers' do
      expect(@solver.factorial(1)).to eq(1)
      expect(@solver.factorial(3)).to eq(6)
      expect(@solver.factorial(5)).to eq(120)
    end

    it 'raises an exception for negative integers' do
      expect { @solver.factorial(-1) }.to raise_error(ArgumentError)
    end
  end

  describe '#reverse' do
    it 'reverses the given word' do
      expect(@solver.reverse('hello')).to eq('olleh')
      expect(@solver.reverse('reverse')).to eq('esrever')
    end
  end

  describe '#fizzbuzz' do
    it 'returns "fizz" when divisible by 3' do
      expect(@solver.fizzbuzz(3)).to eq('fizz')
    end

    it 'returns "buzz" when divisible by 5' do
      expect(@solver.fizzbuzz(5)).to eq('buzz')
    end

    it 'returns "fizzbuzz" when divisible by both 3 and 5' do
      expect(@solver.fizzbuzz(15)).to eq('fizzbuzz')
    end

    it 'returns the number as a string for other cases' do
      expect(@solver.fizzbuzz(7)).to eq('7')
    end
  end
end
