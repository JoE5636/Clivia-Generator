require "pry"
require "httparty"
require "htmlentities"
require "json"
require_relative "presenter"
require_relative "requester"

class CliviaGenerator
  attr_reader :question
  include Presenter
  include Requester
  include HTTParty

  base_uri("https://opentdb.com/") 

  def initialize
    @user = nil
    @question = ""
    @score = 0
  end

  def start
   print_welcome
   input = ""

    until input == "exit"
     input = select_main_menu_action
      
      case input
      when "random"
        @question = random_trivia
        ask_questions
        
      when "scores"
        print_scores
      when "exit" 
        puts "Thanks for playing CLIvia generator"
      end

    end

  end

  def random_trivia
    load_questions
  end

  def ask_questions
    # ask each question
    ask_question(@question)
    
    # if response is correct, put a correct message and increase score
    # if response is incorrect, put an incorrect message, and which was the correct answer
    # once the questions end, show user's score and promp to save it
    will_save?(@score)

  end

  def save(data)
    # write to file the scores data
  end

  def parse_scores
    # get the scores data from file
  end

  def load_questions
    response = self.class.get("/api.php?amount=10")
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    parsed_response[:results]
  end

  def parse_questions(text)
    coder =  HTMLEntities.new
    parsed_text = coder.decode(text)
  end

  def print_scores
    puts "+-----------+-------+"
    puts "|    Top Scores     |"
    puts "+-----------+-------+"
    puts "| Name      | Score |"
    puts "+-----------+-------+"
    puts "| Deyvi     | 40    |"
    puts "| Diego     | 40    |"
    puts "| Wences    | 30    |"
    puts "| Anonymous | 20    |"
    puts "+-----------+-------+"
  end
end
