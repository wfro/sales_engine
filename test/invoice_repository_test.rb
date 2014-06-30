require './test/test_helper'

class ItemRepositoryTest < Minitest::Test
  attr_reader :item_repository

  def setup
    filename = './test/fixtures/invoices.csv'
    @item_repository = InvoiceRepository.load(filename)
  end

  # figure out if these tests are good
  def test_it_loads_Item_objects
    assert_equal '1', item_repository.invoices[0].customer_id
  end
  
  def test_it_returns_all_invoices
    assert item_repository.all.length >= 10
  end
end
