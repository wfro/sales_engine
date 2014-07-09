require_relative 'item'

class ItemRepository
  attr_reader :items,
              :engine

  def initialize(filename, engine)
    @engine = engine
    from_csv(filename)
  end

  def from_csv(filename)
    rows = CSV.open(filename, headers: true, header_converters: :symbol)
    @items = rows.map { |row| Item.new(row, self) }
  end

  def all
    @items
  end

  def random
    items.sample
  end

  def find_by_id(match)
    items.detect { |item| item.id == match }
  end

  def find_by_name(match)
    items.detect { |item| item.name.downcase == match.downcase }
  end

  def find_by_unit_price(match)
    items.detect { |item| item.unit_price == match }
  end

  def find_by_merchant_id(match)
    items.detect { |item| item.merchant_id == match }
  end

  def find_all_by_name(match)
    items.select { |item| item.name.downcase == match.downcase }
  end

  def find_all_by_unit_price(match)
    items.select { |item| item.unit_price == match }
  end

  def find_all_by_merchant_id(match)
    items.select { |item| item.merchant_id == match }
  end

  def most_revenue(x)
    items.sort_by { |i| i.revenue }.reverse[0..x-1]
  end

  def most_items(x=1)
    hash = Hash.new(0)
    
    items.each do |item|
      item.invoice_items.each do |invoice_item|
        hash[item] += invoice_item.quantity
      end
    end
    results = hash.sort_by { |k, v| v }.reverse
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
