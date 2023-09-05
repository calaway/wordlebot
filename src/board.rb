require 'selenium-webdriver'
require 'capybara/dsl'

Capybara.default_driver = :selenium
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

module UiHelpers
  def first_letter_empty?(row)
    find("div[aria-label='Row #{row}'] div[aria-label*='1st letter']")['data-state'] == 'empty'
  end

  def click_keyboard(letter)
    find("div[aria-label='Keyboard'] button[data-key='#{letter}']").click
  end

  def wait_for_animation(row)
    until find("div[aria-label='Row #{row}'] div[aria-label*='5th letter']")['data-state'] != 'tbd'; end
  end

  def get_results(row)
    wait_for_animation(row)
    all("div[aria-label='Row #{row}'] div[data-testid='tile']").map{ |tile| tile['data-state']}
  end
end

class Board
  include Capybara::DSL
  include UiHelpers

  def load
    visit('https://www.nytimes.com/games/wordle/index.html')
    word_list = File.readlines('./src/word-list-small.txt').map(&:chomp)
    click_button('Continue')
    click_button('Play')
    find('button[aria-label="Close"]').click
    word_list
  end

  def submit_word(row, word)
    word = 'dummy' if word.nil?
    letters = word.split('')
    while first_letter_empty?(row) do
      click_keyboard(letters.first)
    end
    letters[1..].each do |letter|
      click_keyboard(letter)
    end
    click_keyboard('↵')

    get_results(row)
  end
end
