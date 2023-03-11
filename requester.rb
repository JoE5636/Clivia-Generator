require_relative "presenter"
require "htmlentities"

module Requester
  def select_main_menu_action
    options = ["random", "scores", "exit"]
    gets_option(prompt: nil, options: options, required: true)
  end

  def ask_question(question)
    input = ""
    parsed_text = ""
    question.each do |item|
      puts "Category: #{item[:category]} | Difficulty: #{item[:difficulty]}"
      parse_questions(item[:question])
      # puts "Question: #{parsed_text}"
      print_answers(item)
    end
    input
  end

  def will_save?(score)
    print_score(score)
    loop do
      puts "Do you want to save your score? (y/n)"
      print "> "
      input = gets.chomp.downcase
      return unless input == "y"
      puts "Type the name to assign to the score"
      print "> "
      name = gets.chomp
      @name = name.empty? ? "Anonymus" : name
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




def print_answers(item)
  input = ""
  if item[:type] == "multiple"
    incorrect = item[:incorrect_answers]
    correct = item[:correct_answer]
    answers = incorrect << correct
    shuffled_answers = answers.shuffle
    printed_answers = shuffled_answers.each_index { |index| puts "#{index +1 }. #{shuffled_answers[index]}" }
    print "> "
    input = gets.chomp.to_i
    increase_score(input, shuffled_answers, correct, incorrect)
  elsif item[:type] == "boolean"
    incorrect = item[:incorrect_answers]
    correct = item[:correct_answer]
    answers = incorrect << correct
    shuffled_answers = answers.shuffle
    printed_answers = shuffled_answers.each_index { |index| puts "#{index + 1}. #{shuffled_answers[index]}" }
    print "> "
    input = gets.chomp.to_i
    increase_score(input, shuffled_answers, correct, incorrect)
  end
 input
end

def parse_questions(text)
  coder = HTMLEntities.new
  parsed_text = coder.decode(text)
  puts "Question: #{parsed_text}"
end


def increase_score(input, shuffled_answers, correct, incorrect)
  if input - 1 == shuffled_answers.index(correct)
    puts "Correct answer!!"
    @score += 10
  else
    puts "Incorrect answer :("
    puts "The correct answer is #{correct}"
  end
  
end


