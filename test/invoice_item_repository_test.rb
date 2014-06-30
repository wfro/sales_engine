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
end
