class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at
              
  def initialize(data)
    @id         = data[:id]
    @name       = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end
  
  # def items
  #   # returns a collection of Item instances associated with that merchant for the products they sell
  # end

  # def invoices
  #   # returns a collection of Invoice instances associated with that merchant from their known orders
  # end
  #
  # def revenue
  #   # returns the total revenue for that merchant across all transactions
  # end
  #
  # def revenue(date)
  #   #  returns the total revenue for that merchant for a specific invoice date
  # end
  #
  # def favorite_customer
  #   # returns the Customer who has conducted the most successful transactions
  # end
  #
  # def customers_with_pending_invoices
  #   # returns a collection of Customer instances which have pending (unpaid) invoices
  # end
end
