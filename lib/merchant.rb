require_relative 'item_repository'
require_relative 'invoice_repository'

class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at
              
  def initialize(data)
    @id         = data[:id]
    @name       = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @items      = Item
  end
  
  def items(file='./data/items.csv')
    ItemRepository.load(file).find_all_by_merchant_id(id)
  end

  def invoices(file='./data/invoices.csv')
    InvoiceRepository.load(file).find_all_by_merchant_id(id)
  end
  
  # def revenue
  #   # returns the total revenue for that merchant across all transactions
  # end
  #
  # def revenue(date)
  #   #  returns the total revenue for that merchant for a specific invoice date
  # end
  #
  # def favorite_customer
  #   # returns the Customer who has conducted the most successful transactions
  # end
  #
  # def customers_with_pending_invoices
  #   # returns a collection of Customer instances which have pending (unpaid) invoices
  # end
end
