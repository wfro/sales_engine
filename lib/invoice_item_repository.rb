require 'csv'
require_relative 'invoice_item'

class InvoiceItemRepository
  attr_reader :invoice_items,
              :engine

  def initialize(filename, engine)
    @filename = filename
    @engine = engine
    from_csv(filename)
  end

  def from_csv(filename)
    rows = CSV.open(filename, headers: true, header_converters: :symbol)
    @invoice_items = rows.map { |row| InvoiceItem.new(row, engine) }
  end

  def create(items, invoice_id, time)
    items.each do |item|
      new_invoice_item = {}

      new_invoice_item[:id]         = all.length + 1
      new_invoice_item[:item_id]    = item.id
      new_invoice_item[:invoice_id] = invoice_id
      new_invoice_item[:quantity]   = items.count(item)
      new_invoice_item[:unit_price] = item.unit_price
      new_invoice_item[:created_at] = time
      new_invoice_item[:updated_at] = time

      all << InvoiceItem.new(new_invoice_item, engine)
    end
  end

  def all
    @invoice_items
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

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end
end
