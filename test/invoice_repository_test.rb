require './test/test_helper'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader :invoice_repository, :engine

  def setup
    @engine = SalesEngine.new('./test/fixtures')
    @invoice_repository = engine.invoice_repository
  end

  # figure out if these tests are good
  def test_it_loads_Item_objects
    assert_equal 1, invoice_repository.invoices[0].customer_id
  end

  def test_it_returns_all_invoices
    assert invoice_repository.all.length >= 10
  end

  def test_find_by_id
    results = invoice_repository.find_by_id(1)
    assert_equal 26, results.merchant_id
  end

  def test_find_by_customer_id
    results = invoice_repository.find_by_customer_id(3)
    assert_equal 86, results.merchant_id
  end

  def test_find_by_merchant_id
    results = invoice_repository.find_by_merchant_id(86)
    assert_equal 3, results.customer_id
  end

  def test_find_by_status
    results = invoice_repository.find_by_status('shipped')
    assert_equal 26, results.merchant_id
  end

  def test_find_all_by_id
    results = invoice_repository.find_all_by_id(1)
    assert_equal 26, results[0].merchant_id
  end

  def test_find_all_by_customer_id
    results = invoice_repository.find_all_by_customer_id(3)
    assert_equal 86, results[0].merchant_id
  end

  def test_find_all_by_merchant_id
    results = invoice_repository.find_all_by_merchant_id(86)
    assert_equal 3, results[0].customer_id
  end

  def test_find_all_by_status
    results = invoice_repository.find_all_by_status('shipped')
    assert_equal 26, results[0].merchant_id
  end

  def test_it_creates_new_invoices
    previous_length = invoice_repository.invoices.length
    customer = engine.customer_repository.find_by_id(1)
    merchant = engine.merchant_repository.find_by_id(2)
    items    = (1..3).map { engine.item_repository.random }
    invoice  = engine.invoice_repository.create(customer: customer, merchant: merchant, items: items)

    assert_equal previous_length + 1, invoice_repository.invoices.length
    assert_equal invoice.merchant_id, merchant.id
    assert_equal invoice.customer.id, customer.id
  end
end
