class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(data)
    @id          = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status      = data[:status]
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
  end


  # def transactions
  #   # returns a collection of associated Transaction instances
  # end
  #
  # def invoice_items
  #   # returns a collection of associated InvoiceItem instances
  # end
  #
  # def items
  #   # returns a collection of associated Items by way of InvoiceItem objects
  # end
  # def customer
  #   # returns an instance of Customer associated with this object
  # end
  #
  # def merchant
  #   # returns an instance of Merchant associated with this object
  # end
end
