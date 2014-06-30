require './test/test_helper'

class ItemTest < Minitest::Test
  def entry
    {
      id: 1,
      name: "counterstrike",
      description: "vidya",
      unit_price: 15,
      merchant_id: 28,
      created_at: "5 oclock",
      updated_at: "6 oclock"
    }
  end

  def test_item_attributes
    item = Item.new(entry)
    assert_equal 1, item.id
    assert_equal "counterstrike", item.name
    assert_equal 15, item.unit_price
    assert_equal 28, item.merchant_id
    assert_equal "5 oclock", item.created_at
    assert_equal "6 oclock", item.updated_at
  end
end
