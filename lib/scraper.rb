require 'pry'
require 'open-uri'
require 'nokogiri'

class Scraper
  
  def self.initial_scrape
    html = open('http://www.sjgames.com/gurps/books/')
    page = Nokogiri::HTML(html)
    topics_table = page.css("table[border=0]").css("tr")[0]
    series_table = page.css("table[border=0]").css("tr")[3]
    book_table = page.css("div.wblist")
    binding.pry
  end
  
end

Scraper.initial_scrape