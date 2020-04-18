require_relative "../lib/gurps_cli/version.rb"
require_relative "../lib/scraper.rb"
require_relative "../lib/books.rb"

binding.pry

module GurpsCli
  class Error < StandardError; end
end
