class Topics
  
  attr_accessor :name, :link
  @@all = []
  
  def initialize(hash)
    hash.each {|symbol, value| self.send(("#{symbol}="),value)}
    @@all << self
  end
  
  def self.print
    @@all.each {|topic| puts topic.name}
  end
  
  def self.all
    @@all
  end
  
end