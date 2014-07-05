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
    invoices = engine.invoice_repository.find_all_by_customer_id(id)
    invoices.map { |invoice| invoice.transactions }
  end

  # def favorite_merchant
  #   # returns an instance of Merchant where the customer has conducted the most successful transactions
  # end
end
