class Words
  attr_accessor :possible_words

  def initialize
    @possible_words = read_word_list_small
  end

  def read_word_list_small
    File.readlines('./src/word-list-small.txt').map(&:chomp)
  end

  def read_word_list_big
    word_list_small = File.readlines('./src/word-list-small.txt').map(&:chomp)
    word_list_big = File.readlines('./src/word-list-big.txt').map(&:chomp)
    (word_list_small + word_list_big).uniq
  end

  def filter(word_list, guess, word_result)
    word_list.delete(guess)

    word_result.each_with_index do |letter_result, index|
      if letter_result == 'correct'
        word_list = word_list.select do |word|
          word[index] == guess[index]
        end
      end

      if letter_result == 'present'
        word_list = word_list.select do |word|
          word.include?(guess[index]) && word[index] != guess[index]
        end
      end

      if letter_result == 'absent'
        absent_letter = guess[index]

        is_letter_present = false
        guess.split('').each_with_index do |letter, inner_index|
          if letter == absent_letter && word_result[inner_index] != 'absent'
            is_letter_present = true
            break
          end
        end

        if !is_letter_present
          word_list = word_list.select do |word|
            !word.include?(guess[index])
          end
        end
      end
    end

    word_list
  end
end
