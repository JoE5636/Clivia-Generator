# do not forget to require your gem dependencies
require "pry"
require "httparty"
require "htmlentities"
require "json"
require_relative "presenter"
require_relative "requester"
class CliviaGenerator
  attr_reader :question
  # maybe we need to include a couple of modules?
  include Presenter
  include Requester
  include HTTParty
  #{}include Encoding
  
  
  base_uri("https://opentdb.com/") 

  def initialize
    # we need to initialize a couple of properties here
    @user = nil
    @question = ""
    @score = []
  end

  def start
   print_welcome
   input = ""

    until input == "exit"
     input = select_main_menu_action
      
      case input
      when "random"
        @question = load_questions

        ask_questions
        
        
      when "scores"
        puts "pinta los scores"
      when "exit" 
        puts "Thanks for playing CLIvia generator"
      end

    end

  end

  def random_trivia
    # load the questions from the api
    # questions are loaded, then let's ask them
  end

  def ask_questions
    # ask each question
    ask_question(@question)
    
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
    response = self.class.get("/api.php?amount=10")
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    @question = parsed_response[:results]
    p @question
    
    
  end

  def parse_questions(text)
    coder =  HTMLEntities.new
    parsed_text = coder.decode(text)
  end

  def print_scores
    # print the scores sorted from top to bottom
  end
end
