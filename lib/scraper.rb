require 'pry'
require 'open-uri'
require 'nokogiri'

class Scraper
  
  def self.initial_scrape
    html = open('http://www.sjgames.com/gurps/books/')
    page = Nokogiri::HTML(html)
    binding.pry
  end
  
end