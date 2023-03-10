module Requester
  def select_main_menu_action
    options = [ "random", "scores", "exit" ]
    gets_option(prompt: nil, options: options, required: true)
  end

  def ask_question(question)
    input = ""
    question.each do |item|
     puts "Category: #{item[:category]} | Difficulty: #{item[:difficulty]}"
      puts "Question: #{item[:question]}"
      #{}puts
      if item[:type] === "multiple"
        puts "1. option"
        puts "2. option"
        puts "3. option"
        puts "4. option"
        print "> "
        input = gets.chomp.to_i
      elsif item[:type] === "boolean"
        puts "1. option"
        puts "2. option"
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
    if input == "y"
      puts "Type the name to assign to the score"
      print "> "
      name = gets.chomp
      @name = name.empty? ? "Anonymus" : name
    elsif input == "n"
    end
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
