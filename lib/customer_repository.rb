require_relative 'customer'

class CustomerRepository
  attr_reader :customers,
              :engine

  def initialize(filename, engine)
    @engine = engine
    from_csv(filename)
  end

  def from_csv(filename)
    rows = CSV.open(filename, headers: true, header_converters: :symbol)
    @customers = rows.map {|row| Customer.new(row, self)}
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
    customers.detect { |customer| customer.first_name.downcase == match.downcase }
  end

  def find_by_last_name(match)
    customers.detect { |customer| customer.last_name.downcase == match.downcase }
  end

  def find_all_by_id(match)
    customers.select { |customer| customer.id == match }
  end

  def find_all_by_first_name(match)
    customers.select { |customer| customer.first_name.downcase == match.downcase }
  end

  def find_all_by_last_name(match)
    customers.select { |customer| customer.last_name.downcase == match.downcase }
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
