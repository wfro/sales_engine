class Invoice
  def transactions
    # returns a collection of associated Transaction instances
  end

  def invoice_items
    # returns a collection of associated InvoiceItem instances
  end

  def items
    # returns a collection of associated Items by way of InvoiceItem objects
  end
  def customer
    # returns an instance of Customer associated with this object
  end
  
  def merchant
    # returns an instance of Merchant associated with this object
  end
end
