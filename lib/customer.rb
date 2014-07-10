require 'date'

class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :engine

  def initialize(data, engine)
    @id           = data[:id].to_i
    @first_name   = data[:first_name]
    @last_name    = data[:last_name]
    @created_at   = Date.parse(data[:created_at])
    @updated_at   = Date.parse(data[:updated_at])
    @engine       = engine
  end

  def invoices
    engine.invoice_repository.find_all_by_customer_id(id)
  end

  def paid_invoices
    invoices.select do |invoice|
      invoice.transactions.any? { |t| t.result == 'success' }
    end
  end

  def paid_invoice_items
    paid_invoices.map do |invoice|
      engine.invoice_item_repository.find_all_by_invoice_id(invoice.id)
    end.flatten
  end

  def items_bought
    paid_invoice_items.inject(0) { |sum, item| sum += item.quantity }
  end

  def value
    paid_invoices.inject(0) { |result, invoice| result + invoice.amount}
  end

  def transactions
    invoices.map { |invoice| invoice.transactions }.flatten
  end

  def favorite_merchant
    merchants = transactions.map { |t| t.merchant if t.result == 'success' }
    merchants.group_by { |item| item }.values.max_by(&:size).first
  end

  def pending_invoices
    invoices.reject { |i| i.successful? }.map do |invoice|
      engine.invoice_repository.find_all_by_id(invoice.id)
    end.flatten
  end
end
