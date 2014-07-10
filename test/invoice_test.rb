require './test/test_helper'

class InvoiceTest < Minitest::Test
  attr_reader :invoice, :engine

  def setup
    @engine = SalesEngine.new('./test/fixtures')
    @invoice = engine.invoice_repository.invoices[0]
  end

  def test_invoice_attributes_are_processed
    assert_equal 1, invoice.id
    assert_equal 1, invoice.customer_id
    assert_equal 26, invoice.merchant_id
  end

  def test_it_converts_dates_to_Date_objects
    assert invoice.created_at
    assert invoice.updated_at
    assert_equal Date, invoice.created_at.class
    assert_equal Date, invoice.updated_at.class
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
    assert invoice.customer.id == 1
  end

  def test_it_finds_the_merchant_on_an_invoice
    assert invoice.respond_to? :merchant
    assert invoice.merchant
    assert invoice.merchant.id == 26
  end

  def test_it_finds_successful_invoices
    assert invoice.respond_to? :successful?
    assert_equal true, invoice.successful?
  end

  def test_charge_creates_a_new_transaction
    transactions = engine.transaction_repository.all
    previous_length = transactions.length
    invoice.charge(credit_card_number: '1111222233334444',  credit_card_expiration_date: "10/14", result: "success")
    assert_equal previous_length + 1, transactions.length
  end
end
