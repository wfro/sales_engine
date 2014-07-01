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

  def all
    invoice_items
  end
  
  def random
    invoice_items.sample
  end
  
  def find_by_item_id(match)
    invoice_items.detect {|invoice_item| invoice_item.item_id == match }
  end
  
  def find_by_quantity(match)
    invoice_items.detect {|invoice_item| invoice_item.quantity == match }
  end
  
  def find_by_id(match)
    invoice_items.detect {|invoice_item| invoice_item.id == match }
  end
  
  def find_by_invoice_id(match)
    invoice_items.detect {|invoice_item| invoice_item.invoice_id == match }
  end
  
  def find_all_by_item_id(match)
    invoice_items.select {|invoice_item| invoice_item.item_id == match }
  end
  
  def find_all_by_quantity(match)
    invoice_items.select {|invoice_item| invoice_item.quantity == match }
  end
  
  def find_all_by_id(match)
    invoice_items.select {|invoice_item| invoice_item.id == match }
  end
  
  def find_all_by_invoice_id(match)
    invoice_items.select { |invoice_item| invoice_item.invoice_id == match }
  end
end
