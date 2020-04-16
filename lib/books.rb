class Books
  
  attr_accessor :title, :edition, :print_status, :page_url, :description
  @@all = []
  
  def initialize(hash)
     hash.each {|symbol, value| self.send(("#{symbol}="),value)}
     @@all << self
  end
  
end