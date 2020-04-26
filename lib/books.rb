class Books
  
  attr_accessor :title, :edition, :print_status, :page_url, :description, :scraped
  @@all = []
  
  def initialize(hash)
     hash.each {|symbol, value| self.send(("#{symbol}="),value)}
     @@all << self
     @scraped = false
  end

  def print
    if self.edition == "3E"
      p_edition = "Third Edition"
    elsif self.edition == "4E"
      p_edition = "Fourth Edition"
    end
    puts "#{self.title}, #{p_edition}, #{self.print_status}"
  end

  def self.print_books
    @@all.each do |book|
      book.print
    end
  end

  def self.import(array)
    array.each {|book_hash| self.new(book_hash)}
  end

  def self.find_by_title(name)
    self.all.find {|book| book.title == name}
  end

  def self.find_by_link(link)
    self.all.find {|book| book.page_url == link}
  end

  def self.all
    @@all
  end
  
end