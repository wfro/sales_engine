require 'bigdecimal'
require 'date'


class Item
  attr_reader :id,
              :name,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :engine,
              :paid_invoice_items

  def initialize(data, item_repo_ref)
    @id            = data[:id].to_i
    @name          = data[:name]
    @unit_price    = BigDecimal.new(data[:unit_price].to_i) / BigDecimal(100)
    @merchant_id   = data[:merchant_id].to_i
    @created_at    = Date.parse(data[:created_at])
    @updated_at    = Date.parse(data[:updated_at])
    @engine        = item_repo_ref.engine
  end

  def invoice_items
    engine.invoice_item_repository.find_all_by_item_id(id)
  end

  def paid_invoice_items
    @paid_invoice_items ||= invoice_items.select { |i| i.invoice.successful? }
  end

  def merchant
    engine.merchant_repository.find_by_id(merchant_id)
  end

  def revenue
    paid_invoice_items.inject(0) { |sum, i| sum += (i.unit_price * i.quantity) }
  end

  def best_day
    daily_invoice_items = paid_invoice_items.group_by { |invoice_item| invoice_item.invoice.updated_at }
    daily_invoice_items.values.flatten!
    daily_invoice_items.each do |key, value|
      daily_invoice_items[key] = value.inject(0) { |sum, invoice_item| sum + invoice_item.quantity }
    end
    best_day = daily_invoice_items.max_by { |k, v| v }
    best_day[0]
    
    # returns the date with the most sales for the given item using the invoice date
  end
end
