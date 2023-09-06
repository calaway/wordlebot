require 'json'
require 'fileutils'

class DataStore
  attr_accessor :db

  def initialize
    if File.exist?('data/db.json')
      read
    else
      @db = {}
    end
  end

  def read
    @db = JSON.parse(File.read('data/db.json'))
  end

  def save
    FileUtils.mkdir_p('data')
    FileUtils.touch('data/db.json')
    File.write('data/db.json', JSON.pretty_generate(@db))
  end
end
