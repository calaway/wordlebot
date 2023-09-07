require_relative 'src/data_store'
require_relative 'src/words'
require_relative 'src/board'

data_store = DataStore.new
pp data_store.db
words = Words.new
board = Board.new

begin
  board.load_wordle(data_store.db)
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
rescue
  Board.save_screenshot('failure')
end

puts "Score: #{game_result}"
remote_data = board.get_local_storage_item('nyt-wordle-moogle/ANON')
data_store.db['remote_data'] = JSON.parse(remote_data)
data_store.save

sleep 3
