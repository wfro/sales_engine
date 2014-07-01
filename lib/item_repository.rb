require_relative 'item'

class ItemRepository
  def self.load(filename='./data/items.csv')
    rows = CSV.open(filename, headers: true, header_converters: :symbol)
    items = rows.map { |row| Item.new(row) }
    new(items)
  end

  attr_reader :items

  def initialize(items)
    @items = items
  end

  def all
    @items
  end

  def random
    items.sample
  end
  
  def find_by_name(match)
    items.detect {|item| item.name.downcase == match.downcase}
  end
  
  def find_by_unit_price(match)
    items.detect {|item| item.unit_price.downcase == match.downcase}
  end
  
  def find_by_merchant_id(match)
    items.detect {|item| item.merchant_id.downcase == match.downcase}
  end
  
  def find_all_by_name(match)
    items.select {|item| item.name.downcase == match.downcase}
  end
  
  def find_all_by_unit_price(match)
    items.select {|item| item.unit_price.downcase == match.downcase}
  end
  
  def find_all_by_merchant_id(match)
    items.select {|item| item.merchant_id.downcase == match.downcase}
  end
  # def most_revenue(x)
  #   # returns the top x item instances ranked by total revenue generated
  # end
  #
  # def most_items(x)
  #   # returns the top x item instances ranked by total number sold
  # end
end
