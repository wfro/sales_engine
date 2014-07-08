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
    invoice_items = []
    invoices.each do |invoice|
      if invoice.successful?
        invoice_items << engine.invoice_item_repository.find_all_by_invoice_id(invoice.id)
      end
    end
    invoice_items.flatten!
    # invoices.collect { |invoice| engine.invoice_item_repository.find_all_by_invoice_id(invoice.id) }.flatten

    # invoices.map { |invoice| engine.invoice_item_repository.find_all_by_invoice_id(invoice.id) }.flatten
  end

  def paid_invoices
    invoices.select { |invoice| invoice.transactions.any? { |t| t.result == 'success' } }
  end

  def paid_invoice_items
    paid_invoices.map { |invoice| engine.invoice_item_repository.find_all_by_invoice_id(invoice.id) }.flatten
  end

  def revenue(date=nil)
    if date
      items_by_date = invoice_items.select { |invoice_item| invoice_item.created_at == date }
      items_by_date.flatten.inject(0) do |result, invoice_item|
        result + (BigDecimal(invoice_item.quantity) * invoice_item.unit_price)
      end
    else
      paid_invoice_items.inject(0) do |result, invoice_item|
        result + (BigDecimal(invoice_item.quantity) * invoice_item.unit_price)
      end
    end
  end

  def sold_items
    invoice_items.inject(0) {|sum, item| sum += item.quantity}
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

  def customers_with_pending_invoices
    unsuccessful_invoices = []
    invoices.each do |invoice|
      unsuccessful_invoices << invoice if invoice.successful? == false
    end
    deadbeat_customers = []
    unsuccessful_invoices.each do |invoice|
      deadbeat_customers << engine.customer_repository.find_all_by_id(invoice.customer_id)
    end
    deadbeat_customers
    # returns a collection of Customer instances which have pending (unpaid) invoices
  end
end
