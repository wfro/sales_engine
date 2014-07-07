require './test/test_helper'

class ItemTest < Minitest::Test
  attr_reader :item

  def setup
    engine = SalesEngine.new('./test/fixtures/')
    @item = engine.item_repository.items[0]
  end

  def test_item_attributes
    assert_equal 1, @item.id
    assert_equal "Item Qui Esse", @item.name
    assert_equal 1, @item.merchant_id
  end

  def test_it_converts_unit_price_to_BigDecimal
    assert_equal BigDecimal.new('751.07'), item.unit_price
    assert_equal BigDecimal, item.unit_price.class
  end

  def test_it_retrieves_invoice_items_for_an_item
    assert item.respond_to? :invoice_items
    assert item.invoice_items
    assert item.invoice_items.length >= 1
  end

  def test_it_retrieves_the_merchant_for_an_item
    assert item.respond_to? :merchant
    assert item.merchant
    assert_equal 1, item.merchant.id
  end
end
