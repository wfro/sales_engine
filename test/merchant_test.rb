require './test/test_helper'

class MerchantTest < Minitest::Test
  def entry
    {
     id: 1,
     name: "Schroeder-Jerde",
     created_at: "5 oclock",
     updated_at: "6 oclock"
    }
  end
 
  def test_attributes
    merchant = Merchant.new(entry)
    assert_equal 1, merchant.id
    assert_equal "Schroeder-Jerde", merchant.name
    assert_equal "5 oclock", merchant.created_at
    assert_equal "6 oclock", merchant.updated_at
  end
  
  def test_it_finds_items_by_merchant_id
    merchant = Merchant.new(entry)
    assert merchant.items('./test/fixtures/items.csv').length >= 11
  end
  
  def test_it_finds_invoices_by_merchant_id
    merchant = Merchant.new(entry)
    invoices_length = merchant.invoices('./test/fixtures/invoices.csv').length
    assert invoices_length >= 1
  end
  
  def test_it_finds_revenue
    merchant = Merchant.new(entry)
    assert merchant.revenue >= 1
  end
end
