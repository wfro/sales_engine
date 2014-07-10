require_relative 'invoice'
require 'time'

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
    @invoices = rows.map { |row| Invoice.new(row, engine) }
  end

  def create(invoice_data)
    new_invoice = {}

    new_invoice[:id]          = all.length + 1
    new_invoice[:customer_id] = invoice_data[:customer].id
    new_invoice[:merchant_id] = invoice_data[:merchant].id
    new_invoice[:status]      = invoice_data[:status]
    new_invoice[:created_at]  = Time.new.to_s
    new_invoice[:updated_at]  = Time.new.to_s

    new_invoice_item(
      invoice_data[:items],
      new_invoice[:id],
      new_invoice[:created_at]
    )

    invoice = Invoice.new(new_invoice, engine)
    all << invoice
    invoice
  end

  def new_invoice_item(items, id, time)
    engine.invoice_item_repository.create(items, id, time)
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

  def pending
    invoices.reject { |i| i.successful? }.map do |invoice|
      engine.invoice_repository.find_all_by_id(invoice = invoice.id)
    end.flatten
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end
end
