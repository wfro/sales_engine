class Item
  def invoice_item
    # returns a collection of InvoiceItems associated with this object
  end
  
  def merchant
    # returns an instance of Merchant associated with this object
  end
  
  def best_day
    # returns the date with the most sales for the given item using the invoice date
  end
end
