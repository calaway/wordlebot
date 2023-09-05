require_relative 'src/board'
require_relative 'src/words'

words = Words.new
possible_words = words.possible_words
board = Board.new

game_result = 6.times do |index|
  guess = possible_words.sample
  puts guess
  word_result = board.submit_word(index + 1, guess)
  p word_result
  possible_words = words.filter(possible_words, guess, word_result)
  puts possible_words.length
  if word_result.all? { |result| result == 'correct' }
    break guess
  elsif index == 5
    break possible_words
  end
end

puts game_result

# require 'pry'; binding.pry
