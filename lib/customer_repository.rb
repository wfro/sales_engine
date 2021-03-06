require_relative 'customer'

class CustomerRepository
  attr_reader :customers

  def initialize(filename, engine)
    from_csv(filename, engine)
  end

  def from_csv(filename, engine)
    rows = CSV.open(filename, headers: true, header_converters: :symbol)
    @customers = rows.map {|row| Customer.new(row, engine)}
  end

  def all
    customers
  end

  def random
    customers.sample
  end

  def find_by_id(match)
    customers.detect { |customer| customer.id == match }
  end

  def find_by_first_name(match)
    customers.detect do |customer|
      customer.first_name.downcase == match.downcase
    end
  end

  def find_by_last_name(match)
    customers.detect do |customer|
      customer.last_name.downcase == match.downcase
    end
  end

  def find_all_by_id(match)
    customers.select { |customer| customer.id == match }
  end

  def find_all_by_first_name(match)
    customers.select do |customer|
      customer.first_name.downcase == match.downcase
    end
  end

  def find_all_by_last_name(match)
    customers.select do |customer|
      customer.last_name.downcase == match.downcase
    end
  end

  def most_items
    customers.max_by { |customer| customer.items_bought }
  end

  def most_revenue
    customers.max_by { |customer| customer.value }

  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end
end
