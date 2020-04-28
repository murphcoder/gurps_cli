class Books
  
  attr_accessor :title, :edition, :print_status, :page_url, :description, :scraped
  @@all = []
  
##Creates a book object using information gathered in scraping.

  def initialize(hash)
     hash.each {|symbol, value| self.send(("#{symbol}="),value)}
     @@all << self
     @scraped = false
  end

## Prints title, edition, and print status for a book.

  def print
    if self.edition == "3E"
      p_edition = "Third Edition"
    elsif self.edition == "4E"
      p_edition = "Fourth Edition"
    end
    puts "#{self.title}, #{p_edition}, #{self.print_status}"
  end

##Prints title, edition, and print status for all books.

  def self.print_books
    @@all.each do |book|
      book.print
    end
  end

##Creates multiple books from information in an array.

  def self.import(array)
    array.each {|book_hash| self.new(book_hash)}
  end

##Locates a book based on it's title.

  def self.find_by_title(name)
    self.all.find {|book| book.title == name}
  end

##Calls the @@all class variable and returns an array of all book objects.

  def self.all
    @@all
  end
  
end