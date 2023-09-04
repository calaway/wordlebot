require 'selenium-webdriver'
require 'capybara/dsl'

Capybara.default_driver = :selenium
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

class Board
  include Capybara::DSL

  def initialize
  end

  def load
    visit('https://www.nytimes.com/games/wordle/index.html')

    word_list = File.readlines('./src/word-list-small.txt').map(&:chomp)
    puts "Word list loaded. #{word_list.length} words found."

    click_button('Continue')
    click_button('Play')
    find('button[aria-label="Close"]').click

    word_list
  end

  def submit_word(row, word)
    letters = word.split('')
    while find("div[aria-label='Row #{row}'] div[aria-label*='1st letter']")['data-state'] == 'empty' do
      find("div[aria-label='Keyboard'] button[data-key='#{letters.first}']").click
    end
    letters[1..].each do |letter|
      find("div[aria-label='Keyboard'] button[data-key='#{letter}']").click
    end
    find("div[aria-label='Keyboard'] button[data-key='↵']").click

    get_results(row)
  end

  def get_results(row)
    until find("div[aria-label='Row #{row}'] div[aria-label*='5th letter']")['data-state'] != 'tbd'; end
    all("div[aria-label='Row #{row}'] div[data-testid='tile']").map{ |tile| tile['data-state']}
  end
end
