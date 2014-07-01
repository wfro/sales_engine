require './test/test_helper'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader :item_repository

  def setup
    filename = './test/fixtures/invoices.csv'
    @item_repository = InvoiceRepository.load(filename)
  end

  # figure out if these tests are good
  def test_it_loads_Item_objects
    assert_equal 1, item_repository.invoices[0].customer_id
  end

  def test_it_returns_all_invoices
    assert item_repository.all.length >= 10
  end

  def test_find_by_id
    results = item_repository.find_by_id(1)
    assert_equal 26, results.merchant_id
  end

  def test_find_by_customer_id
    results = item_repository.find_by_customer_id(3)
    assert_equal 86, results.merchant_id
  end

  def test_find_by_merchant_id
    results = item_repository.find_by_merchant_id(86)
    assert_equal 3, results.customer_id
  end

  def test_find_by_status
    results = item_repository.find_by_status('shipped')
    assert_equal 26, results.merchant_id
  end

  def test_find_all_by_id
    results = item_repository.find_all_by_id(1)
    assert_equal 26, results[0].merchant_id
  end

  def test_find_all_by_customer_id
    results = item_repository.find_all_by_customer_id(3)
    assert_equal 86, results[0].merchant_id
  end

  def test_find_all_by_merchant_id
    results = item_repository.find_all_by_merchant_id(86)
    assert_equal 3, results[0].customer_id
  end

  def test_find_all_by_status
    results = item_repository.find_all_by_status('shipped')
    assert_equal 26, results[0].merchant_id
  end
end
