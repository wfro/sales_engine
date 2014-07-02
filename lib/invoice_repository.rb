require_relative 'invoice'

class InvoiceRepository
  attr_reader :invoices,
              :engine

  def initialize(filename, engine)
    @filename = filename
    @engine   = engine
    from_csv(filename)
  end

  def from_csv(filename)
    rows = CSV.open(filename, headers: true, header_converters: :symbol)
    @invoices = rows.map { |row| Invoice.new(row, self) }
  end

  def all
    invoices
  end

  def random
    invoices.sample
  end

  def find_by_id(match)
    invoices.detect { |invoice| invoice.id == match }
  end

  def find_by_customer_id(match)
    invoices.detect { |invoice| invoice.customer_id == match }
  end

  def find_by_merchant_id(match)
    invoices.detect { |invoice| invoice.merchant_id == match }
  end

  def find_by_status(match)
    invoices.detect { |invoice| invoice.status.downcase == match.downcase }
  end

  def find_all_by_id(match)
    invoices.select { |invoice| invoice.id == match }
  end

  def find_all_by_customer_id(match)
    invoices.select { |invoice| invoice.customer_id == match }
  end

  def find_all_by_merchant_id(match)
    invoices.select { |invoice| invoice.merchant_id == match }
  end

  def find_all_by_status(match)
    invoices.select { |invoice| invoice.status.downcase == match.downcase }
  end
end
