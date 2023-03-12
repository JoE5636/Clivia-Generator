require "pry"
require "httparty"
require "json"
require "terminal-table"
require_relative "presenter"
require_relative "requester"


class CliviaGenerator
  attr_accessor :question, :name, :score, :filename

  include Presenter
  include Requester
  include HTTParty

  base_uri("https://opentdb.com/")

  def initialize(filename)
    @name = nil
    @question = []
    @score = 0
    @filename = filename
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
        puts print_scores
      when "exit"
        puts ["$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$",
              "$ Thank you for playig Clivia Generator $",
              "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"].join("\n")
        puts "Created with love by JoE"
      end

    end
  end

  def ask_questions
    ask_question(@question)
    will_save?(@score)
  end

  def parse_scores
    begin
     JSON.parse(File.read(@filename), symbolize_names: true)
     rescue Errno::ENOENT
    end
  end

  def load_questions
    response = self.class.get("/api.php?amount=10")
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    parsed_response[:results]
  end

  def print_scores
    scores = parse_scores.sort_by! { |score| -(score[:score]) }
    table = Terminal::Table.new
    table.title = "Top Scores"
    table.headings = ["Name", "score"]
    table.rows = scores.map do |score|
      [score[:name], score[:score] || ""]
    end

    table
  end
end
