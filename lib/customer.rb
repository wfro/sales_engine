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
    merchants = transactions.map { |t| t.merchant if t.result == 'success' }
    merchants.group_by { |item| item }.values.max_by(&:size).first
  end

end
