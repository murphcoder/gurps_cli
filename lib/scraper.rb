require 'pry'
require 'open-uri'
require 'nokogiri'

class Scraper
  
  def self.initial_scrape
    html = open('http://www.sjgames.com/gurps/books/')
    page = Nokogiri::HTML(html)
    topics_table = page.css("table[border=0]").css("tr")[0]
    ## topics_table.css("a").text extracts name of topic
    ## topics_table.css("a")["href"] extracts link to book page
    series_table = page.css("table[border=0]").css("tr")[3]
    ## series_table.css("a").text extracts name of topic
    ## series_table.css("a")["href"] extracts link to book page
    book_table = page.css("div.wblist")
    ## book_table.css("a").text extracts name of topic
    ## book_table.css("a")["href"] extracts link to book page
    ## Must skip single letter headings
    binding.pry
  end
  
end

Scraper.initial_scrape