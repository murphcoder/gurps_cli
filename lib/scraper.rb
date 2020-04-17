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

    ## Loop Code
    ## code.css("span").text determines edition
    ## code.css("a").first.text determines title
    ## code.css("a").first["href"] determines page_url
    ## code.css("a")[1]["title"] determines print status

    book = book_table.xpath("//h3[1]/following::*") & book_table.xpath("//br[1]/preceding::*")
    
    binding.pry
  end

end

def get_book_data(book)
  l_title = book.css("a").first.text
  l_edition = book.css("span").text
  print = book.css[1]["title"]
  if print == "W23-D"
    l_print_status = "Digital"
  elsif print == "W23" && book.css[2]["title"] == "W23-D"
    l_print_status = "Both"
  elsif print == "W23" && !book.css[2]["title"] == "W23-D"
    l_print_status = "Physical"
  elsif print == nil
    l_print_status = "Out Of Print"
  end
  l_page_url = "http://sjgames.com#{book.css("a").first["href"]}"
  {:title => l_title, :edition => l_edition, :print_status => l_print_status, :page_url => l_page_url}
end

Scraper.new