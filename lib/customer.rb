class Customer
  def invoices
    # returns a collection of Invoice instances associated with this object.
  end
  
  def transactions
    # returns an array of Transaction instances associated with the customer
  end
  
  def favorite_merchant
    # returns an instance of Merchant where the customer has conducted the most successful transactions
  end
end
