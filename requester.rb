module Requester
  def select_main_menu_action
    options = ["random", "scores", "exit"]
    gets_option(prompt: nil, options: options, required: true)
  end

  def ask_question(question)
    input = ""
    question.each do |item|
      puts "Category: #{item[:category]} | Difficulty: #{item[:difficulty]}"
      puts "Question: #{item[:question]}"
      if item[:type] == "multiple"
        incorrect = item[:incorrect_answers]
        correct = item[:correct_answer]
        answers = incorrect << correct
        shuffled_answers = answers.shuffle
        puts "1. #{shuffled_answers[0]}\n2. #{shuffled_answers[1]}\n3. #{shuffled_answers[2]}\n4. #{shuffled_answers[3]}"
        print "> "
        input = gets.chomp.to_i
      elsif item[:type] == "boolean"
        incorrect = item[:incorrect_answers]
        correct = item[:correct_answer]
        answers = incorrect << correct
        shuffled_answers = answers.shuffle
        puts "1. #{shuffled_answers[0]}"
        puts "2. #{shuffled_answers[1]}"
        print "> "
        input = gets.chomp
      end
      input
    end
  end

  def will_save?(score)
    print_score(score)
    puts "Do you want to save your score? (y/n)"
    print "> "
    input = gets.chomp.downcase
    return unless input == "y"

    puts "Type the name to assign to the score"
    print "> "
    name = gets.chomp
    @name = name.empty? ? "Anonymus" : name
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
