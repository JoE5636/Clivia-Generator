require_relative "presenter"
require "json"
require "htmlentities"

module Requester
  def select_main_menu_action
    options = ["random", "scores", "exit"]
    gets_option(options: options, required: true)
  end

  def ask_question(question)
    input = ""
    question.each do |item|
      puts "Category: #{item[:category]} | Difficulty: #{item[:difficulty]}"
      parse_questions(item[:question])
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
      if input == "y"
        puts "Type the name to assign to the score"
        print "> "
        name = gets.chomp
        @name = name.empty? ? "Anonymus" : name
        save(@name, score)
        break
      elsif input == "n"
        break
      end
    end
  end

  def gets_option(options:, required: nil)
    input = ""
    loop do
      puts options.join(" | ")
      print "> "
      input = gets.chomp.downcase
      # input = (input == nil ? "nuevo valor" : input)
      break if options.include?(input) || (input.empty? && !required)

      puts "Invalid option"
    end
    input
  end
end

private

def print_answers(item)
  input = ""
  incorrect = item[:incorrect_answers]
  correct = item[:correct_answer]
  answers = incorrect << correct
  shuffled_answers = answers.shuffle
  if item[:type] == "multiple"
    shuffled_answers.each_index { |index| puts "#{index + 1}. #{shuffled_answers[index]}" }
    print "> "
    input = gets.chomp.to_i
    increase_score(input, shuffled_answers, correct)
  elsif item[:type] == "boolean"
    shuffled_answers.each_index { |index| puts "#{index + 1}. #{shuffled_answers[index]}" }
    print "> "
    input = gets.chomp.to_i
    increase_score(input, shuffled_answers, correct)
  end
  input
end

def parse_questions(text)
  coder = HTMLEntities.new
  parsed_text = coder.decode(text)
  puts "Question: #{parsed_text}"
end

def increase_score(input, shuffled_answers, correct)
  if input - 1 == shuffled_answers.index(correct)
    puts "Correct answer!!"
    @score += 10
  else
    puts "Incorrect answer :("
    puts "The correct answer is #{correct}"
  end
end

def save(name, score)
  scores = JSON.parse(File.read("score.json"))
  data = { name: name, score: score } 
  scores << data
  File.write("score.json", JSON.generate(scores))
end