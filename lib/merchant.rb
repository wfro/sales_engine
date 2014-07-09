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
    invoices.map do |invoice|
      engine.invoice_item_repository.find_all_by_invoice_id(invoice.id)
    end.flatten
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

  def revenue(date=nil)
    if date
      by_date = paid_invoices.select { |invoice| invoice.updated_at == date }
      by_date.inject(0) { |result, invoice| result + invoice.amount }
    else
      paid_invoices.inject(0) { |result, invoice| result + invoice.amount}
    end
  end

  def sold_items
    paid_invoice_items.inject(0) {|sum, item| sum += item.quantity}
  end

  def customers
    invoices.map { |invoice| invoice.customer }
  end

  def favorite_customer
    upstanding_customers = customers.select do |customer|
      customer.transactions.any? { |t| t.result == 'success' }
    end
    upstanding_customers.group_by { |item| item }.values.max_by(&:size).first
  end

  def customers_with_pending_invoices
    invoices.reject { |i| i.successful? }.map do |invoice|
      engine.customer_repository.find_all_by_id(invoice.customer_id)
    end.flatten
  end
end
