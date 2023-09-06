require_relative 'src/words'
require_relative 'src/board'

words = Words.new
board = Board.new

game_result = 6.times do |index|
  guess = words.possible_words.sample
  puts "Guess: #{guess}"
  word_result = board.submit_word(index + 1, guess)
  Board.pretty_print_result(word_result)
  words.possible_words = words.filter(words.possible_words, guess, word_result)
  puts "Possible words remaining: #{words.possible_words.length}"
  puts

  if word_result.all? { |result| result == 'correct' }
    break index + 1
  elsif index == 5
    break 7
  end
end

puts game_result

sleep 3
