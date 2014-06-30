class MerchantRepository
  def all
  end
  
  def random
    # returns a random instance
  end
  
  def find_by_X(match)
    # where X is some attribute, returns a single instance whose X attribute case-insensitive attribute matches the match parameter. For instance, Customer.find_by_first_name("Mary") could find a Customer with the first name attribute "Mary" or "mary" but not "Mary Ellen".
  end
  
  def find_all_by_X(match)
    #  works just like find_by_X except it returns a collection of all matches. If there is no match, it returns an empty Array.
  end
  
  def most_revenue(X)
    # returns the top x merchant instances ranked by total revenue
  end
  
  def most_items(x)
    # returns the top x merchant instances ranked by total number of items sold
  end
  
  def revenue(date)
    # returns the total revenue for that date across all merchants
  end
end
