require 'bigdecimal'
require 'date'

class Item
  attr_reader :id,
              :name,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :engine

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

  def merchant
    engine.merchant_repository.find_by_id(merchant_id)
  end

  def revenue
    invoice_items.inject(0) do |sum, invoice_item|
      if invoice_item.invoice.successful?
        sum += (invoice_item.unit_price * invoice_item.quantity)
      else
        sum
      end
    end
  end

  # def best_day
  #   # returns the date with the most sales for the given item using the invoice date
  # end
end
