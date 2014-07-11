require 'date'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :engine

  def initialize(data, engine)
    @id          = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status      = data[:status]
    @created_at  = Date.parse(data[:created_at])
    @updated_at  = Date.parse(data[:updated_at])
    @engine      = engine
  end

  def charge(charge_data)
    charge_data[:invoice_id] = id
    engine.transaction_repository.create(charge_data)
  end

  def transactions
    engine.transaction_repository.find_all_by_invoice_id(id)
  end

  def invoice_items
    engine.invoice_item_repository.find_all_by_invoice_id(id)
  end

  def items
    invoice_items.map do |invoice_item|
      engine.item_repository.find_by_id(invoice_item.item_id)
    end
  end

  def amount
    invoice_items.inject(0) do |result, invoice_item|
      result + (BigDecimal(invoice_item.quantity) * invoice_item.unit_price)
    end
  end

  def customer
    engine.customer_repository.find_by_id(customer_id)
  end

  def merchant
    engine.merchant_repository.find_by_id(merchant_id)
  end

  def successful?
    transactions.any? {|t| t.result == 'success'}
  end
end
