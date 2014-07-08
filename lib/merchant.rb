require 'date'

class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :engine

  def initialize(data, merchant_repo_ref)
    @id                = data[:id].to_i
    @name              = data[:name].to_s
    @created_at        = Date.parse(data[:created_at])
    @updated_at        = Date.parse(data[:updated_at])
    @engine            = merchant_repo_ref.engine
  end

  def items
    engine.item_repository.find_all_by_merchant_id(id)
  end

  def items_sold
    items.each do |item|
      item
    end
  end

# remove items that have not been sold
# multiply items by invoice_item.quantity


  def invoices
    engine.invoice_repository.find_all_by_merchant_id(id)
  end

  def invoice_items
    invoices.map { |invoice| engine.invoice_item_repository.find_all_by_invoice_id(invoice.id) }.flatten
  end

  def paid_invoices
    invoices.select { |invoice| invoice.transactions.any? { |t| t.result == 'success' } }
  end

  def paid_invoice_items
    paid_invoices.map { |invoice| engine.invoice_item_repository.find_all_by_invoice_id(invoice.id) }.flatten
  end

  def revenue(date=nil)
    puts date
    if date
      by_date = paid_invoices.select { |invoice| invoice.updated_at == date }
      by_date.inject(0) { |result, invoice| result + invoice.amount }
    else
      paid_invoices.inject(0) { |result, invoice| result + invoice.amount}
    end
  end

  def favorite_customer
    # customers = invoices.map { |invoice| invoice.customer }
    # customer_hash = {}
    # customers.each { |customer| customer_hash[customer] = customer.transactions.length }
    # customer_hash.max_by{ |k, v| v }[0]
    customers = invoices.map { |invoice| invoice.customer }
    all_customers = customers.each do |customer|
      customer.transactions.map do |transaction|
        customer if transaction.result == 'success'
      end
    end
    all_customers.group_by { |item| item }.values.max_by(&:size).first
  end

  # def customers_with_pending_invoices
  #   # returns a collection of Customer instances which have pending (unpaid) invoices
  # end
end
