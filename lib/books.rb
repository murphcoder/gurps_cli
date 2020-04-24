class Books
  
  attr_accessor :title, :edition, :print_status, :page_url, :description
  @@all = []
  
  def initialize(hash)
     hash.each {|symbol, value| self.send(("#{symbol}="),value)}
     @@all << self
  end

  def self.print_books
    @@all.each do |book|
      if book.edition == "3E"
        p_edition = "Third Edition"
      elsif book.edition == "4E"
        p_edition = "Fourth Edition"
      end
      puts "#{book.title}, #{p_edition}, #{book.print_status}"
    end
  end

  def self.import_books(array)
    array.each {|book_hash| self.new(book_hash)}
  end

  def self.find_by_title(name)
    self.all.find {|book| book.title == name}}
  end

  def self.find_by_link(link)
    self.all.find {|book| book.page_url == link}
  end

  def self.all
    @@all
  end
  
end