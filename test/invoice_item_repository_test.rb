require './test/test_helper'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :invoice_item_repository
  def setup
    filename = './test/fixtures/invoice_items.csv'
    @invoice_item_repository = InvoiceItemRepository.load(filename)
  end
  
  def test_it_loads_invoice_item_objects
    assert_equal "539", invoice_item_repository.invoice_items[0].item_id
  end
  
  def test_it_returns_all_invoice_items
    assert invoice_item_repository.all.length >= 10
  end
  
  def test_it_finds_by_item_id
    results = invoice_item_repository.find_by_item_id('539')
    assert_equal results.id, "1"

    results = invoice_item_repository.find_by_item_id('539')
    refute_equal results.id, "2"
  end
  
  def test_it_finds_by_quantity
    results = invoice_item_repository.find_by_quantity('5')
    assert_equal results.id, "1"

    results = invoice_item_repository.find_by_quantity('5')
    refute_equal results.id, "2"
  end
  
  def test_it_finds_by_id
    results = invoice_item_repository.find_by_id('1')
    assert_equal results.quantity, "5"

    results = invoice_item_repository.find_by_id('1')
    refute_equal results.quantity, "9"
  end
  
  def test_it_finds_all_by_item_id
    results = invoice_item_repository.find_all_by_item_id('539')
    assert_equal results[0].id, "1"

    results = invoice_item_repository.find_all_by_item_id('539')
    refute_equal results[0].id, "2"
  end
  
  def test_it_finds_all_by_quantity
    results = invoice_item_repository.find_all_by_quantity('5')
    assert_equal results[0].id, "1"

    results = invoice_item_repository.find_all_by_quantity('5')
    refute_equal results[0].id, "2"
  end
  
  def test_it_finds_all_by_id
    results = invoice_item_repository.find_all_by_id('1')
    assert_equal results[0].quantity, "5"

    results = invoice_item_repository.find_all_by_id('1')
    refute_equal results[0].quantity, "9"
  end
end
