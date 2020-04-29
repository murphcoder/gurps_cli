require 'pry'
require 'open-uri'
require 'nokogiri'

class Scraper
  
  attr_reader :topics, :series, :books
  
## Scrapes the main page's list of books, topics, and series. Some topics and series are hard coded to be avoided as they are either redundant or link to outside websites.

  def initialize
    @topics = []
    @series = []
    @books = []
    html = open('http://www.sjgames.com/gurps/books/')
    page = Nokogiri::HTML(html)
    topics_table = page.css("table[border=0]").css("tr")[0]
    topics_table.css("a").each do |topic|
      if topic.text != "Fourth Edition" && topic.text != "Older Editions"
        @topics << {:name => topic.text, :link => "/gurps/books/#{topic["href"]}"}
      end
    end
    series_table = page.css("table[border=0]").css("tr")[3]
    series_table.css("a").each do |series|
      if series.text != "GURPS Prime Directive" && series.text != "Pyramid"
        @series << {:name => series.text, :link => series["href"]}
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
  end

## Gathers title, print status, edition, and description url for an individual book.

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
            l_print_status = "Available as a PDF"
          elsif print == "W23"
            l_print_status = "Available in print"
         end
        else
          l_print_status = "Available in print, and as a PDF"
        end
      end
      l_page_url = book.css("a").first["href"]
      {:title => l_title, :edition => l_edition, :print_status => l_print_status, :page_url => l_page_url}
    end
  end

## Takes in a link, scrapes the book description off of that page, and returns the description.

  def self.book_desc(link)
    html = open("http://sjgames.com#{link}")
    book_page = Nokogiri::HTML(html)
    desc_array = []
    book_page.css("p").each do |para|
      if !para.text.include?("Available Now at") && !para.text.include?("Always Available") && !para.text.include?("Out Of Print") && !para.text.include?("Contact Us")
        desc_array << para.text.chomp
      end
    end
    desc_array.join("\n\n")
  end

## Takes in a link, scrapes all links off of the main body of that page, and returns them in an array.

  def self.topic_or_series(link)
    html = open("http://sjgames.com#{link}")
    page = Nokogiri::HTML(html)
    list_array = []
    if page.css("td.pagemainpane a").length != 0
      code = "td.pagemainpane a"
    else
      code = "a"
    end
    page.css("a").each do |book|
      if book["href"] != nil
        if !book["href"].include?("warehouse23")
          list_array << book["href"].split("/").last
        end
      end
    end
    list_array
  end

end

