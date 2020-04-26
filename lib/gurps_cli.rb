require_relative "../lib/gurps_cli/version.rb"
require_relative "../lib/scraper.rb"
require_relative "../lib/books.rb"
require_relative "../lib/topics_or_series.rb"

module GurpsCli
  class Error < StandardError; end
  
  def begin(reboot=false)
    puts "Welcome to the GURPS CLI Book Browser! Would you like to see a list of Topics, Series, or an alphabetical list of all Books?"
    puts ""
    puts "Topics"
    puts "Series"
    puts "Books"
    puts ""
    input = gets.strip
    if input != "Topics" && input != "Series" && input != "Books"
      puts "Invalid Input. Please try again."
      beginning
    end
    if reboot == false
      puts "Gathering book data, please be patient. There are a lot of GURPS books!"
      main_scrape = Scraper.new
      Books.import(main_scrape.books)
      Topics.import(main_scrape.topics)
      Series.import(main_scrape.series)
    end
    binding.pry
    if input == "Topics" || input == "Series"
      start_topics_or_series(input)
    elsif input == "Books"
      Books.print_books
      select_book
    end
  end

  def start_topics_or_series(t_or_s)
    if t_or_s == "Topics"
      word = "Topic"
      list = Topics
    elsif t_or_s == "Series"
      word = "Series"
      list = Series
    end
    list.print
    puts "Enter a #{word} for a list of books in that #{word}."
    input = gets.strip
    choice = list.find_by_name(input)
    if choice == nil
      puts "Invalid input. Please try again."
      start_topics_or_series(t_or_s)
    else
      if choice.scraped == false
        scrape_topic_or_series(choice)
      end
      choice.books.each {|book| book.print}
      select_book
    end
  end

  def scrape_topic_or_series(choice)
    link_array = Scraper.topic_or_series(choice.link)
    Books.all.each do |book|
      if link_array.include?(book.page_url)
        choice.books << book
      end
    end
    choice.scraped = true
  end

  def select_book
    puts "Please select a book from the previous list."
    input = gets.strip
    if Books.all.all? {|book| book.title != input}
      puts "Invalid input."
      select_book
    else
      book = Books.find_by_title(input)
      if book.scraped == false
        book.description = Scraper.book_desc(book.page_url)
        book.scraped = true
      end
      puts book.description
      final
    end
  end

  def final
    puts "Would you like to Return to the main menu, or End the program?"
    puts ""
    puts "Return"
    puts "End"
    input = gets.strip
    if input == "Return"
      self.begin(true)
    elsif input == "End"
      puts "Thank you, and Good Bye!"
    else
      puts "Invalid input."
      final
    end
  end

end

class Test
  include GurpsCli
  def initialize
    self.begin
  end
end

Test.new