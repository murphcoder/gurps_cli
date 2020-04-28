## The Series and Topics classes are virtually identical, so you may ask why they do not share a module.

## Whenever I tried to code them using a common module, they ended up sharing a common @@all variable.

## Coding them separately was the only way I could make them work.


class Series
    
  attr_accessor :name, :link, :books, :scraped
  @@all = []
  
##Takes a hash provided by the Scraper and creates a Series object.

  def initialize(hash)
    hash.each {|symbol, value| self.send(("#{symbol}="),value)}
    @@all << self
    @books = []
    @scraped = false
  end

##Imports an array of hashes and creates a Series object for each.
  
  def self.import(array)
    array.each {|book_hash| self.new(book_hash)}
  end

##Locates a series by name.

  def self.find_by_name(title)
    @@all.find {|topic| topic.name == title}
  end

##Prints all series.
  
  def self.print
    @@all.each {|topic| puts topic.name}
  end

##Calls on the @@all class variable and returns an array of all series.
  
  def self.all
    @@all
  end
end

class Topics
    
  attr_accessor :name, :link, :books, :scraped
  @@all = []
  
##Takes a hash provided by the Scraper and creates a Topic object.

  def initialize(hash)
    hash.each {|symbol, value| self.send(("#{symbol}="),value)}
    @@all << self
    @books = []
    @scraped = false
  end

##Imports an array of hashes and creates a Topic object for each.
  
  def self.import(array)
    array.each {|book_hash| self.new(book_hash)}
  end

##Locates a topic by name.

  def self.find_by_name(title)
    @@all.find {|topic| topic.name == title}
  end

##Prints all topics.
  
  def self.print
    @@all.each {|topic| puts topic.name}
  end

##Calls on the @@all class variable and returns an array of all topics.
  
  def self.all
    @@all
  end
  
end