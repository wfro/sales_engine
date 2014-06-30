class Item
  attr_reader :id,
              :name,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at
              
  def initialize(data)
    @id          = data[:id]
    @name        = data[:name]
    @unit_price  = data[:unit_price]
    @merchant_id = data[:merchant_id]
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
  end

  # def invoice_item
  #   # returns a collection of InvoiceItems associated with this object
  # end
  #
  # def merchant
  #   # returns an instance of Merchant associated with this object
  # end
  #
  # def best_day
  #   # returns the date with the most sales for the given item using the invoice date
  # end
end
