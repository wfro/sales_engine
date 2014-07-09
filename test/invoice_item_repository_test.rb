require './test/test_helper'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :invoice_item_repository

  def setup
    engine = SalesEngine.new('./test/fixtures')
    @invoice_item_repository = engine.invoice_item_repository
  end

  def test_it_loads_invoice_item_objects
    assert_equal 539, invoice_item_repository.invoice_items[0].item_id
  end

  def test_it_returns_all_invoice_items
    assert invoice_item_repository.all.length >= 10
  end

  def test_it_finds_by_item_id
    results = invoice_item_repository.find_by_item_id(539)
    assert_equal results.id, 1

    results = invoice_item_repository.find_by_item_id(539)
    refute_equal results.id, 2
  end

  def test_it_finds_by_quantity
    results = invoice_item_repository.find_by_quantity(8)
    assert_equal results.quantity, 8

    results = invoice_item_repository.find_by_quantity(8)
    refute_equal results.quantity, 9
  end

  def test_it_finds_by_id
    results = invoice_item_repository.find_by_id(1)
    assert_equal results.id, 1

    results = invoice_item_repository.find_by_id(1)
    refute_equal results.id, 9
  end

  def test_it_finds_by_invoice_id
    results = invoice_item_repository.find_by_invoice_id(1)
    assert_equal results.id, 1

    results = invoice_item_repository.find_by_invoice_id(1)
    refute_equal results.id, 9
  end

  def test_it_finds_all_by_invoice_id
    results = invoice_item_repository.find_all_by_invoice_id(1)
    assert results.length >= 8

    results = invoice_item_repository.find_all_by_invoice_id(1)
    refute results.length < 8
  end

  def test_it_finds_all_by_item_id
    results = invoice_item_repository.find_all_by_item_id(539)
    assert_equal results[0].id, 1

    results = invoice_item_repository.find_all_by_item_id(539)
    refute_equal results[0].id, 2
  end

  def test_it_finds_all_by_quantity
    results = invoice_item_repository.find_all_by_quantity(5)
    assert_equal results[0].id, 1

    results = invoice_item_repository.find_all_by_quantity(5)
    refute_equal results[0].id, 2
  end

  def test_it_finds_all_by_id
    results = invoice_item_repository.find_all_by_id(1)
    assert_equal results[0].quantity, 5

    results = invoice_item_repository.find_all_by_id(1)
    refute_equal results[0].quantity, 9
  end

  def test_it_creates_new_invoices
      customer = engine.customer_repository.find_by_id(1)
      merchant = engine.merchant_repository.find_by_id(2)
      items    = (1..3).map { engine.item_repository.random }

      invoice = engine.invoice_repository.create(customer: customer, merchant: merchant, items: items)

      
      items.map(&:name).each do |name|
        invoice.items.map(&:name).should include(name)
      end

      invoice.merchant_id.should == merchant.id
      invoice.customer.id.should == customer.id
  end
end
