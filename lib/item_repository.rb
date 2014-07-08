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
  # def most_revenue(x)
  #   # returns the top x item instances ranked by total revenue generated
  # end
  #
  def most_items(x=nil)
    # invoice_items = engine.invoice_item_repository.invoice_items
    # hash = invoice_items.group_by { |invoice_item| invoice_item.item }
    # hash.max_by { |k, v| v.length }
    hash = {}
    items.each { |item| hash[item] = 0 }
    items.each { |item| hash[item] += item.invoice_items.length }

    hash.max_by { |k, v| v }[0]
    # returns the top x item instances ranked by total number sold
  end
  
  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
