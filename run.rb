require 'pry'

require_relative 'src/board'
require_relative 'src/words'

board = Board.new

word_list = board.load

guess = word_list.sample
puts guess
results = board.submit_word(1, guess)
p results
puts word_list.length

word_list = Words.filter(word_list, guess, results)
guess = word_list.sample
puts guess
results = board.submit_word(2, guess)
p results
puts word_list.length

word_list = Words.filter(word_list, guess, results)
guess = word_list.sample
puts guess
results = board.submit_word(3, guess)
p results
puts word_list.length

word_list = Words.filter(word_list, guess, results)
guess = word_list.sample
puts guess
results = board.submit_word(4, guess)
p results
puts word_list.length

word_list = Words.filter(word_list, guess, results)
guess = word_list.sample
puts guess
results = board.submit_word(5, guess)
p results
puts word_list.length

word_list = Words.filter(word_list, guess, results)
guess = word_list.sample
puts guess
results = board.submit_word(6, guess)
p results
puts word_list.length


binding.pry
