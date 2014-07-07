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

  def invoices
    engine.invoice_repository.find_all_by_merchant_id(id)
  end

  def invoice_items
    invoices.collect { |invoice| engine.invoice_item_repository.find_all_by_invoice_id(invoice.id) }.flatten
  end

  def revenue(date=nil)
    if date
      items_by_date = invoice_items.select { |invoice_item| invoice_item.created_at == date }
      items_by_date.flatten.inject(0) do |result, invoice_item|
        result + (BigDecimal(invoice_item.quantity) * invoice_item.unit_price)
      end
    else
      invoice_items.inject(0) do |result, invoice_item|
        result + (BigDecimal(invoice_item.quantity) * invoice_item.unit_price)
      end
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
