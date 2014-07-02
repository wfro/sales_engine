require './test/test_helper'

class MerchantTest < Minitest::Test
  def setup
    engine = SalesEngine.new('./test/fixtures')
    @merchant = engine.merchant_repository.merchants[0]
  end

  def test_attributes
    assert_equal 1, @merchant.id
    assert_equal "Schroeder-Jerde", @merchant.name
  end

  def test_it_finds_items_by_merchant_id
    assert @merchant.items.length >= 11
  end

  def test_it_finds_invoices_by_merchant_id
    invoices_length = @merchant.invoices.length
    assert invoices_length >= 1
  end

  def test_it_finds_revenue
    skip
    puts merchant.revenue
    assert @merchant.revenue >= 1
  end
end
