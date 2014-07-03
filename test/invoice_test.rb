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

  def test_it_finds_all_invoice_items_on_an_invoice
    assert invoice.respond_to? :invoice_items
    assert invoice.invoice_items
    assert invoice.invoice_items.length >= 1
  end

  def test_it_finds_all_items_on_an_invoice
    assert invoice.respond_to? :items
    assert invoice.items
    assert invoice.items.length >= 1
  end

  def test_it_finds_the_customer_on_an_invoice
    assert invoice.respond_to? :customer
    assert invoice.customer
    assert invoice.customer_id == 1
  end

  def test_it_finds_the_merchant_on_an_invoice
    assert invoice.respond_to? :merchant
    assert invoice.merchant
    assert invoice.merchant_id == 26
  end
end
