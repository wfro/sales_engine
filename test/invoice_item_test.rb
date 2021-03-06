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

  def test_dates_are_converted_to_Date_objects
    assert invoice_item.created_at
    assert invoice_item.updated_at
    assert_equal Date, invoice_item.created_at.class
    assert_equal Date, invoice_item.updated_at.class
  end

  def test_it_converts_unit_price_to_BigDecimal
    assert_equal BigDecimal('136.35'), invoice_item.unit_price
    assert_equal BigDecimal, invoice_item.unit_price.class
  end

  def test_it_retrieves_invoice_for_an_invoice_item
    assert invoice_item.respond_to? :invoice
    assert invoice_item.invoice
    assert invoice_item.invoice.id == 1
  end

  def test_it_retrieves_item_for_an_invoice_item
    assert invoice_item.respond_to? :item
    assert invoice_item.item
    assert_equal BigDecimal('136.35'), invoice_item.item.unit_price
  end
end
