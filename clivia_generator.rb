require "pry"
require "httparty"
require "json"
require_relative "presenter"
require_relative "requester"

class CliviaGenerator
  attr_accessor :question, :name, :score

  include Presenter
  include Requester
  include HTTParty

  base_uri("https://opentdb.com/")

  def initialize
    @name = nil
    @question = []
    @score = 0
  end

  def start
    input = ""

    until input == "exit"
      print_welcome
      input = select_main_menu_action

      case input
      when "random"
        @question = load_questions
        ask_questions

      when "scores"
        print_scores
      when "exit"
        puts "Thank you for playing CLIvia generator!!!"
        puts "Created with love by JoE"
      end

    end
  end

  def ask_questions
    ask_question(@question)
    will_save?(@score)
  end

  def parse_scores
    parsed_scores = JSON.parse(score.json, symbolize_names: true)
  end

  def load_questions
    response = self.class.get("/api.php?amount=10")
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    parsed_response[:results]
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
