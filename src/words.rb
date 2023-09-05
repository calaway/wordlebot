module Words
  def self.filter(word_list, guess, word_result)
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
        word_list = word_list.select do |word|
          !word.include?(guess[index])
        end
      end
    end
    word_list
  end
end
