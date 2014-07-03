require './test/test_helper'

class InvoiceItemTest < Minitest::Test
  attr_reader :invoice_item

  def setup
    engine = SalesEngine.new('./test/fixtures')
    @invoice_item = engine.invoice_item_repository.invoice_items[0]
  end

  def test_attributes_are_processed
    assert_equal 1, invoice_item.id
  end

  def test_it_retrieves_invoice_for_this_object
    assert invoice_item.respond_to? :invoice
    assert invoice_item.invoice
    assert invoice_item.invoice.id == 1
  end

  def test_it_retrieves_item_for_this_object
    assert invoice_item.respond_to? :item
    assert invoice_item.item
    assert_equal 13635, invoice_item.item.unit_price
  end
end
