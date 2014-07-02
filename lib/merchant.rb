require 'pry'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'

class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at

  def initialize(data, merchant_repo_ref)
    @id                = data[:id].to_i
    @name              = data[:name]
    @created_at        = data[:created_at]
    @updated_at        = data[:updated_at]
    @merchant_repo_ref = merchant_repo_ref
  end

  def items
    @merchant_repo_ref.engine.item_repository.find_all_by_merchant_id(id)
  end

  def invoices
    @merchant_repo_ref.engine.invoice_repository.find_all_by_merchant_id(id)
  end

  def get_invoice_items
    invoices.collect { |invoice|
 @invoice_item_repository.find_all_by_invoice_id(invoice.id) }
  end

  def revenue
    invoice_items = get_invoice_items
    revenue = 0
    invoice_items.flatten.each do |invoice_item|
      revenue += (invoice_item.quantity * invoice_item.unit_price)
    end
    revenue
  end

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
