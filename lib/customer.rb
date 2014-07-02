class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(data)
    @id         = data[:id].to_i
    @first_name = data[:first_name]
    @last_name  = data[:last_name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  # def invoices
  #   # returns a collection of Invoice instances associated with this object.
  # end
  #
  # def transactions
  #   # returns an array of Transaction instances associated with the customer
  # end

  # def favorite_merchant
  #   # returns an instance of Merchant where the customer has conducted the most successful transactions
  # end
end
