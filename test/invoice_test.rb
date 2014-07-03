require './test/test_helper'

class InvoiceTest < Minitest::Test
  attr_reader :invoice

  def setup
    engine = SalesEngine.new('./test/fixtures')
    @invoice = engine.invoice_repository.invoices[0]
  end

  def test_invoice_attributes_are_processed
    assert_equal 1, invoice.id
    assert_equal 1, invoice.customer_id
    assert_equal 26, invoice.merchant_id
  end

  def test_it_finds_all_transactions_on_an_invoice
    assert invoice.respond_to? :transactions
    assert invoice.transactions
    assert invoice.transactions.length >= 1
  end
end
