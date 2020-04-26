class Series
    
  attr_accessor :name, :link, :books, :scraped
  @@all = []
  
  def initialize(hash)
    hash.each {|symbol, value| self.send(("#{symbol}="),value)}
    @@all << self
    @books = []
    @scraped = false
  end
  
  def self.import(array)
    array.each {|book_hash| self.new(book_hash)}
  end

  def self.find_by_name(title)
    @@all.find {|topic| topic.name == title}
  end
  
  def self.print
    @@all.each {|topic| puts topic.name}
  end
  
  def self.all
    @@all
  end
end

class Topics
    
  attr_accessor :name, :link, :books, :scraped
  @@all = []
  
  def initialize(hash)
    hash.each {|symbol, value| self.send(("#{symbol}="),value)}
    @@all << self
    @books = []
    @scraped = false
  end
  
  def self.import(array)
    array.each {|book_hash| self.new(book_hash)}
  end

  def self.find_by_name(title)
    @@all.find {|topic| topic.name == title}
  end
  
  def self.print
    @@all.each {|topic| puts topic.name}
  end
  
  def self.all
    @@all
  end
end