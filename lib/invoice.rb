class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :engine

  def initialize(data, invoice_repo_ref)
    @id               = data[:id].to_i
    @customer_id      = data[:customer_id].to_i
    @merchant_id      = data[:merchant_id].to_i
    @status           = data[:status]
    @created_at       = data[:created_at]
    @updated_at       = data[:updated_at]
    @engine           = invoice_repo_ref.engine
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

  def customer
    engine.invoice_repository.find_by_customer_id(customer_id)
  end

  def merchant
    engine.invoice_repository.find_by_merchant_id(merchant_id)
  end
end
