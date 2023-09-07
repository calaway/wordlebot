require 'selenium-webdriver'
require 'capybara/dsl'
require 'fileutils'
require 'time'

Capybara.default_driver = :selenium
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

module UiHelpers
  def set_local_storage_item(key, value)
    execute_script("localStorage.setItem('#{key}', '#{value}');")
  end

  def get_local_storage_item(key)
    evaluate_script("localStorage.getItem('#{key}');")
  end

  def initialize_local_storage(db)
    local_storage_inputs = { 'accepted_terms_service' => 'true' }
    if db['remote_data']
      local_storage_inputs['nyt-wordle-moogle/ANON'] = JSON.generate(db['remote_data'])
    end
    local_storage_inputs.each do |key, value|
      set_local_storage_item(key, value)
    end
    refresh
  end

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

  def load_wordle(db = {})
    visit('https://www.nytimes.com/games/wordle/index.html')
    initialize_local_storage(db)
    click_button('Play')
    find('button[aria-label="Close"]').click
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

  def self.pretty_print_result(word_result)
    emoji_translation = { 'correct' => '🟢', 'present' => '🟡', 'absent' => '⚪️'}
    emoji_result = word_result.map do |letter_result|
      emoji_translation[letter_result]
    end.join('')
    puts emoji_result
  end

  def self.save_screenshot(result)
    FileUtils.mkdir_p('screenshots')
    Capybara.save_screenshot("screenshots/#{result} - #{Time.now.to_s}.png")
  end
end
