require_relative "clivia_generator"

# capture command line arguments (ARGV)
filename = ARGV[0] || "score.json" 
ARGV.clear
data = []
if File.exists?(filename)
  begin 
  data = JSON.parse(File.read(filename))
  rescue JSON::ParserError
    Array.new
  end 
end
File.open(filename, "w") do |file|
file.write(JSON.pretty_generate(data))
end

trivia = CliviaGenerator.new(filename)
trivia.start
