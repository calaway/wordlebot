require 'pry'

require_relative 'src/board'
require_relative 'src/words'

board = Board.new

word_list = board.load

game_result = 6.times do |index|
  guess = word_list.sample
  puts guess
  word_result = board.submit_word(index + 1, guess)
  p word_result
  word_list = Words.filter(word_list, guess, word_result)
  puts word_list.length
  if word_result.all? { |result| result == 'correct' }
    break guess
  elsif index == 5
    break word_list
  end
end

puts game_result

binding.pry
