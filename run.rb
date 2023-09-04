require 'selenium-webdriver'
require 'capybara/dsl'
require 'pry'

Capybara.default_driver = :selenium
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

include Capybara::DSL

# Navigate to game
visit('https://www.nytimes.com/games/wordle/index.html')
click_button('Continue')
click_button('Play')
find('button[aria-label="Close"]').click

# Submit first word
def submit_word(row, word)
  letters = word.split('')
  while find("div[aria-label='Row #{row}'] div[aria-label*='1st letter']")['data-state'] == 'empty' do
    find("div[aria-label='Keyboard'] button[data-key='#{letters.first}']").click
  end
  letters[1..].each do |letter|
    find("div[aria-label='Keyboard'] button[data-key='#{letter}']").click
  end
  find("div[aria-label='Keyboard'] button[data-key='↵']").click
end

submit_word(1, 'brave')
submit_word(2, 'lousy')
submit_word(3, 'shake')
submit_word(4, 'gravy')
submit_word(5, 'large')
submit_word(6, 'troop')

binding.pry
