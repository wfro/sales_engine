require 'bigdecimal'

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
    @unit_price    = BigDecimal.new(data[:unit_price].to_i) / BigDecimal.new(100)
    @merchant_id   = data[:merchant_id].to_i
    @created_at    = data[:created_at]
    @updated_at    = data[:updated_at]
    @engine        = item_repo_ref.engine
  end

  def invoice_items
    engine.invoice_item_repository.find_all_by_item_id(id)
  end

  def merchant
    engine.merchant_repository.find_by_id(merchant_id)
  end

  # def best_day
  #   # returns the date with the most sales for the given item using the invoice date
  # end
end
