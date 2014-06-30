require './test/test_helper'

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    filename = './test/fixtures/invoice_items.csv'
    @invoice_item_repository = InvoiceItemRepository.load(filename)
  end
  
  def test_it_loads_invoice_item_objects
    assert_equal "539", @invoice_item_repository.invoice_items[0].item_id
  end
end
