require 'pry'
require 'open-uri'
require 'nokogiri'

class Scraper
  
  attr_reader :topics, :series, :books
  
  def initialize
    @topics = []
    @series = []
    @books = []
    html = open('http://www.sjgames.com/gurps/books/')
    page = Nokogiri::HTML(html)
    topics_table = page.css("table[border=0]").css("tr")[0]
    topics_table.css("a").each do |topic|
      if topic.text != "Fourth Edition" && topic.text != "Older Editions"
        @topics << {:name => topic.text, :link => "http://sjgames.com/gurps/books/#{topic["href"]}"}
      end
    end
    series_table = page.css("table[border=0]").css("tr")[3]
    series_table.css("a").each do |series|
      if series.text != "GURPS Prime Directive"
        @series << {:name => series.text, :link => "http://sjgames.com#{series["href"]}"}
      end
    end
    book_table = page.css("div.wblist")
    book_code = book_table.xpath("//h3[1]/following::*") & book_table.xpath("//br[1]/preceding::*")
    @books << get_book_data(book_code)
    count = 1
    until book_code.length == 0 do
      book_code = book_table.xpath("//h3[1]/following::br[#{count}]/following::*") & book_table.xpath("//h3[1]/following::br[#{count+1}]/preceding::*")
      book_data = get_book_data(book_code)
      if book_data != nil && book_data[:title].length != 1
        @books << book_data
      end
      count += 1
    end
    binding.pry
  end

end

def get_book_data(book)
  if book.css("a") != nil && book.css("span") != nil && book.css("a").first != nil
    l_title = book.css("a").first.text
    l_edition = book.css("span").text
    if book.css("a")[1] == nil
      l_print_status = "Out Of Print"
    else
      print = book.css("a")[1].text
      if book.css("a")[2] == nil
       if print == "W23-D"
          l_print_status = "Digital"
        elsif print == "W23"
          l_print_status = "Physical"
       end
      else
        l_print_status = "Both"
      end
    end
    l_page_url = "http://sjgames.com#{book.css("a").first["href"]}"
    {:title => l_title, :edition => l_edition, :print_status => l_print_status, :page_url => l_page_url}
  end
end

Scraper.new