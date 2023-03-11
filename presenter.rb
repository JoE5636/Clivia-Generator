module Presenter
  def print_welcome
    puts ["###################################",
          "#   Welcome to Clivia Generator   #",
          "###################################"].join("\n")
  end

  def print_score(score)
    puts "Well done! Your score is #{score}"
    puts "--------------------------------------------------"
  end
end
