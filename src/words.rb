module Words
  def self.filter(word_list, guess, results)
    word_list.delete(guess)
    results.each_with_index do |result, index|
      if result == 'correct'
        word_list = word_list.select do |word|
          word[index] == guess[index]
        end
      end
      if result == 'present'
        word_list = word_list.select do |word|
          word.include?(guess[index]) && word[index] != guess[index]
        end
      end
      if result == 'absent'
        word_list = word_list.select do |word|
          !word.include?(guess[index])
        end
      end
    end
    word_list
  end
end
