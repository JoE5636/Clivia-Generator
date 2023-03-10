module Requester
  def select_main_menu_action
    options = [ "random", "scores", "exit" ]
    gets_option(prompt: nil, options: options, required: true)
  end

  def ask_question(question)
    # show category and difficulty from question
  
    answers = []
    question.each { |key, _value|  answers << (key[:incorrect_answers]) && answers << (key[:correct_answer]) }
    question.each { |key, _value| puts "Category: #{key[:category]} | Difficulty: #{key[:difficulty]}\nQuestion: #{key[:question]}\n1.#{answers[0][rand(0..2)]}" }
      
      
    
    #{}binding.pry
    
    
    # show each one of the options
    # grab user input
  end

  def will_save?(score)
    # show user's score
    # ask the user to save the score
    # grab user input
    # prompt the user to give the score a name if there is no name given, set it as Anonymous
  end

  def gets_option(prompt:, options:, required: nil)
    input = ""
    loop do
      puts options.join(" | ")
      print "> "
      input = gets.chomp
      # input = (input == nil ? "nuevo valor" : input)
      break if options.include?(input) || (input.empty? && !required)

      puts "Invalid option"
    end
    input
  end

end
