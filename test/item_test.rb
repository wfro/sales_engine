require './test/test_helper'

class ItemTest < Minitest::Test

def setup
  engine = SalesEngine.new('./test/fixtures/')
  @item = engine.item_repository.items[0]
end

  def test_item_attributes
    assert_equal 1, @item.id
    assert_equal "Item Qui Esse", @item.name
    assert_equal 75107, @item.unit_price
    assert_equal 1, @item.merchant_id
  end
  
  
end
