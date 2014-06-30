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

  # def all
  # end
  #
  # def random
  #   # returns a random instance
  # end
  #
  # def find_by_X(match)
  #   # where X is some attribute, returns a single instance whose X attribute case-insensitive attribute matches the match parameter. For instance, Customer.find_by_first_name("Mary") could find a Customer with the first name attribute "Mary" or "mary" but not "Mary Ellen".
  # end
  #
  # def find_all_by_X(match)
  #   #  works just like find_by_X except it returns a collection of all matches. If there is no match, it returns an empty Array.
  # end
  #
  # def most_revenue(x)
  #   # returns the top x item instances ranked by total revenue generated
  # end
  #
  # def most_items(x)
  #   # returns the top x item instances ranked by total number sold
  # end
end
