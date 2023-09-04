require 'pry'

require_relative 'src/board'

board = Board.new

word_list = board.load

board.submit_word(1, word_list.sample)
board.submit_word(2, word_list.sample)
board.submit_word(3, word_list.sample)
board.submit_word(4, word_list.sample)
board.submit_word(5, word_list.sample)
board.submit_word(6, word_list.sample)

binding.pry
