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
    customers = invoices.map { |invoice| invoice.customer }
    all_customers = customers.each do |customer|
      customer.transactions.map do |transaction|
        customer if transaction.result == 'success'
      end
    end
    all_customers.group_by { |item| item }.values.max_by(&:size).first

    # customers = invoices.map { |invoice| invoice.customer }
    #
    # hash = {}
    # customers.each { |customer| hash[customer] = 0 }
    #
    # # doing it live
    # customers.each do |customer|
    #   transactions = customer.transactions
    #   transactions.each { |transaction| hash[customer] += 1 if transaction.merchant.id == id }
    # end
    # hash.max_by{ |k, v| v }[0]

    # find customers that shop here
    # loop through customers
    #   for each customer, find transactions that match merchant id
    #   track num transactions per customer, return customer with highest.
    # returns the Customer who has conducted the most successful transactions
  end

  # def customers_with_pending_invoices
  #   # returns a collection of Customer instances which have pending (unpaid) invoices
  # end
end
