require_relative 'app'

def main
  app = App.new

  loop do
    app.display_options
    print 'Select an option: '
    choice = gets.chomp.to_i

    result = app.process(choice)
    break if result == :quit
  end
end

main if __FILE__ == $PROGRAM_NAME
