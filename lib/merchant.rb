class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :engine

  def initialize(data, merchant_repo_ref)
    @id                = data[:id].to_i
    @name              = data[:name]
    @created_at        = data[:created_at]
    @updated_at        = data[:updated_at]
    @engine            = merchant_repo_ref.engine
  end

  def items
    engine.item_repository.find_all_by_merchant_id(id)
  end

  def invoices
    engine.invoice_repository.find_all_by_merchant_id(id)
  end

  def get_invoice_items
    invoices.collect { |invoice| engine.invoice_item_repository.find_all_by_invoice_id(invoice.id) }
  end

  def revenue
    get_invoice_items.flatten.inject(0) do |result, invoice_item|
      result + (invoice_item.quantity * invoice_item.unit_price)
    end
  end

  # def revenue(date)
  #   #  returns the total revenue for that merchant for a specific invoice date
  # end

  def favorite_customer
    # find invoices that match this merchant (sort by customer)
    # customer_ids = invoices.map { |invoice| invoice.customer_id }
    # customer_objects = customer_ids.each { |id| engine.customer_repository.find_by_id(id) }
    # # find customers that match those invoices
    # # find customer ids; return customer objects with find_all_by_id
    # # find successful transactions that match those (X) invoices
    # merchant_transactions = invoices.map { |invoice| engine.transaction_repository.find_all_by_invoice_id(invoice.id) }.flatten
    # successful_transactions = merchant_transactions.select { |transaction| transaction.result == "success" }
    # find customer with most

    # returns the Customer who has conducted the most successful transactions
  end

  # def customers_with_pending_invoices
  #   # returns a collection of Customer instances which have pending (unpaid) invoices
  # end
end
