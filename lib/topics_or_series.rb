class Topics
  
  attr_accessor :name, :link, :books
  @@all = []
  
  def initialize(hash)
    hash.each {|symbol, value| self.send(("#{symbol}="),value)}
    @@all << self
    @books = []
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