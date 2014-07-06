class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :engine

  def initialize(data, customer_repo_ref)
    @id                = data[:id].to_i
    @first_name        = data[:first_name]
    @last_name         = data[:last_name]
    @created_at        = data[:created_at]
    @updated_at        = data[:updated_at]
    @engine            = customer_repo_ref.engine
  end

  def invoices
    engine.invoice_repository.find_all_by_customer_id(id)
  end

  def transactions
    invoices.map { |invoice| invoice.transactions }.flatten
  end

  def favorite_merchant
    # first working? solution:
    #   already have all transactions for a given customer
    #   find merchants associated with transactions (this will be problematic)
    #     multiple transactions from same merchant
    #   for each merchant find its invoices
    #     currently searching through all invoices for a merchant
    #     way to only search invoices attached to this customer?
    #   for each invoice check if the customer_id matches self.id
    #   add one to the hash value of the corresponding merchant
    # and not 15 minutes later found a different solution
    #   we already have all transactions, just create an array adding the
    #   merchant for each transaction, and find which is repeated most
    merchants = transactions.map { |t| t.merchant } #if t.result == 'success' }
    dups = merchants.select{ |element| merchants.count(element) > 1 }
    dups.max
    # merchant_hash = {}

    # # populate the hash
    # merchants.each { |merchant| merchant_hash[merchant] = 0 }

    # # doing it live
    # merchants.each do |merchant|
    #   invoices = merchant.invoices
    #   invoices.each { |invoice| merchant_hash[merchant] += 1 if invoice.customer_id == id }
    # end
    # merchant_hash.max_by{ |k, v| v }[0]
  end

end
