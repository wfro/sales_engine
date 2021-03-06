require 'csv'
require_relative 'merchant'

class MerchantRepository
  attr_reader :merchants

  def initialize(filename, engine)
    from_csv(filename, engine)
  end

  def from_csv(filename, engine)
    rows = CSV.open(filename, headers: true, header_converters: :symbol)
    @merchants = rows.map {|row| Merchant.new(row, engine)}
  end

  def all
    merchants
  end

  def random
    merchants.sample
  end

  def find_by_id(match)
    merchants.detect { |merchant| merchant.id == match }
  end

  def find_by_name(match)
    merchants.detect do |merchant|
      merchant.name.to_s.downcase == match.downcase
    end
  end

  def find_all_by_id(match)
    merchants.select { |merchant| merchant.id == match }
  end

  def find_all_by_name(match)
    merchants.select do |merchant|
      merchant.name.to_s.downcase == match.downcase
    end
  end

  def most_revenue(x)
    merchants.sort_by { |m| m.revenue }.reverse[0...x]
  end

  def most_items(x=1)
    merchants.sort_by { |m| m.sold_items }.reverse[0...x]
  end

  def revenue(date)
    merchants.inject(0) { |sum, merchant| sum += merchant.revenue(date) }
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
