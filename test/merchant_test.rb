require './test/test_helper'

class MerchantTest < Minitest::Test
  
  def entry
    {
     id: 1,
     name: "Jon Snow",
     created_at: "5 oclock",
     updated_at: "6 oclock"
    }
  end
 
  def test_attributes
    merchant = Merchant.new(entry)
    assert_equal 1, merchant.id
    assert_equal "Jon Snow", merchant.name
    assert_equal "5 oclock", merchant.created_at
    assert_equal "6 oclock", merchant.updated_at
  end
end
