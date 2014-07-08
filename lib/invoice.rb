require 'date'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :engine

  def initialize(data, invoice_repo_ref)
    @id          = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status      = data[:status]
    @created_at  = Date.parse(data[:created_at])
    @updated_at  = Date.parse(data[:updated_at])
    @engine      = invoice_repo_ref.engine
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
    engine.customer_repository.find_by_id(customer_id)
  end

  def merchant
    engine.merchant_repository.find_by_id(merchant_id)
  end
  
  def successful?
    if transactions.any? {|t| t.result == 'success'}
      true
    else
      false
    end
  end
  
  # def successful_items
  #   items.select {|i| i.}
  #
  # end
end
