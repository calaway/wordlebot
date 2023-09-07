require 'json'
require 'fileutils'

class DataStore
  attr_accessor :db

  def initialize
    read_db
  end

  def read_db
    if File.exist?('data/db.json')
      @db = JSON.parse(File.read('data/db.json'))
    else
      @db = {}
    end
  end

  def save
    FileUtils.mkdir_p('data')
    FileUtils.touch('data/db.json')
    File.write('data/db.json', JSON.pretty_generate(@db))
  end
end
