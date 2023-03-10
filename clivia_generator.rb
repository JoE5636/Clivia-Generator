# do not forget to require your gem dependencies
require "pry"
require "httparty"
require "htmlentities"
require "json"
require_relative "presenter"
require_relative "requester"
class CliviaGenerator
  # maybe we need to include a couple of modules?
  include Presenter
  include Requester
  include HTTParty
  #{}include Encoding
  
  
  base_uri("https://opentdb.com/") 

  def initialize
    # we need to initialize a couple of properties here
    @user = nil
    @score = []
  end

  def start
   print_welcome
   input = ""

    until input == "exit"
     input = select_main_menu_action
      
      case input
      when "random"
        random_trivia
        ask_questions
      when "scores"
        puts "pinta los scores"
      when "exit" 
        puts "Thanks for playing CLIvia generator"
      end

    end

  end

  def random_trivia
    question = ""
    response = self.class.get("/api.php?amount=10")
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    questions = parsed_response[:results]
    puts questions
    #{}question = questions.
  end

  def ask_questions
    # ask each question
    #{}ask_question(question)
    # if response is correct, put a correct message and increase score
    # if response is incorrect, put an incorrect message, and which was the correct answer
    # once the questions end, show user's score and promp to save it
  end

  def save(data)
    # write to file the scores data
  end

  def parse_scores
    # get the scores data from file
  end

  def load_questions
    # ask the api for a random set of questions
    # then parse the questions
  end

  def parse_questions
    # questions came with an unexpected structure, clean them to make it usable for our purposes
  end

  def print_scores
    # print the scores sorted from top to bottom
  end
end
