require_relative "../lib/gurps_cli/version.rb"
require_relative "../lib/scraper.rb"
require_relative "../lib/books.rb"
require_relative "../lib/topics_or_series.rb"

module GurpsCli
  class Error < StandardError; end
  
  def beginning
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
    puts "Gathering book data, please be patient. There are a lot of GURPS books!"
    main_scrape = Scraper.new
    Books.import(main_scrape.books)
    Topics.import(main_scrape.topics)
    Series.inport(main_scrape.series)
    if input == "Topics"
      start_topics
    elsif input == "Series"
      start_series
    elsif input == "Books"
      start_books
    end
  end

  def start_topics
    Topics.print
    puts "Enter a Topic for a list of books in that Topic."
    input = gets.strip
    chosen_topic == Topics.find_by_name(input)
    if chosen_topic == nil
      puts "Invalid input. Please try again."
      start_topics
    else
      scrape_topic(chosen_topic)
    end
  end

  def scrape_topic(topic)
    link_array = Scraper.topics_or_series(topic.link)
  end

end

binding.pry
