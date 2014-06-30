require 'csv'
require_relative 'invoice_item'

class InvoiceItemRepository
  def self.load(filename='./data/invoice_items.csv')
    rows = CSV.open(filename, headers: true, header_converters: :symbol)
    invoice_items = rows.map { |row| InvoiceItem.new(row) }
    new(invoice_items)
  end
  
  attr_reader :invoice_items
  
  def initialize(invoice_items)
    @invoice_items = invoice_items
  end

  # def all
  # end
  #
  # def random
  #   # returns a random instance
  # end
  #
  # def find_by_X(match)
  #   # where X is some attribute, returns a single instance whose X attribute case-insensitive attribute matches the match parameter. For instance, Customer.find_by_first_name("Mary") could find a Customer with the first name attribute "Mary" or "mary" but not "Mary Ellen".
  # end
  #
  # def find_all_by_X(match)
  #   #  works just like find_by_X except it returns a collection of all matches. If there is no match, it returns an empty Array.
  # end
end
