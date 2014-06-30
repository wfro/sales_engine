require 'csv'
require_relative 'merchant'

class MerchantRepository
  def self.load(filename="./data/merchants.csv")
    rows = CSV.open(filename, headers: true, header_converters: :symbol)
    merchants = rows.map {|row| Merchant.new(row)}
    new(merchants)
  end

  attr_reader :merchants

  def initialize(merchants)
    @merchants = merchants
  end

  def all
    merchants
  end

  def random
    merchants.sample
  end
  
  def find_by_id(match)
    merchants.detect { |merchant| merchant.id.downcase == match.downcase }
  end
  
  def find_by_name(match)
    merchants.detect { |merchant| merchant.name.downcase == match.downcase }
  end

  def find_all_by_id(match)
    merchants.select { |merchant| merchant.id.downcase == match.downcase }
  end
  
  def find_all_by_name(match)
    merchants.select { |merchant| merchant.name.downcase == match.downcase }
  end
  # def most_revenue(X)
  #   # returns the top x merchant instances ranked by total revenue
  # end
  #
  # def most_items(x)
  #   # returns the top x merchant instances ranked by total number of items sold
  # end
  #
  # def revenue(date)
  #   # returns the total revenue for that date across all merchants
  # end
end
