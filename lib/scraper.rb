require 'pry'
require 'open-uri'
require 'nokogiri'

class Scraper
  
  attr_reader :topics, :series, :books
  
  def initialize
    @topics = []
    @series = []
    @books =[]
    html = open('http://www.sjgames.com/gurps/books/')
    page = Nokogiri::HTML(html)
    topics_table = page.css("table[border=0]").css("tr")[0]
    ## topics_table.css("a").text extracts name of topic
    ## topics_table.css("a")["href"] extracts link to book page
    topics_table.css("a").each do |topic|
      @topics << {:name => topic.text, :link => topic["href"]}
    end
    series_table = page.css("table[border=0]").css("tr")[3]
    ## series_table.css("a").text extracts name of topic
    ## series_table.css("a")["href"] extracts link to book page
    series_table.css("a").each do |series|
      @series << {:name => series.text, :link => series["href"]}
    end
    book_table = page.css("div.wblist")
    ## To separate the first block, use: book_table.xpath("//h3[1]/following::*") & book_table.xpath("//br[1]/preceding::*")
    ## Then, create a loop where "counter" starts at 1 an advances each time. Use the following code.
    ## book_table.xpath("//h3[1]/following::br[#{counter}]/following::*") & book_table.xpath("//h3[1]/following::br[#{counter+1}]/preceding::*")
    ## Must skip single letter headings
    binding.pry
  end
  
end

Scraper.new