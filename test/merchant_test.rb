require './test/test_helper'

class MerchantTest < Minitest::Test
  attr_reader :merchant

  def setup
    engine = SalesEngine.new('./test/fixtures')
    @merchant = engine.merchant_repository.merchants[0]
  end

  def test_attributes
    assert_equal 1, @merchant.id
    assert_equal "Schroeder-Jerde", @merchant.name
  end

  def test_it_finds_items_for_a_merchant
    assert merchant.respond_to? :items
    assert merchant.items
    assert merchant.items.length >= 11
  end

  def test_it_finds_invoices_for_a_merchant
    assert merchant.respond_to? :invoices
    assert merchant.invoices
    assert merchant.invoices.length >= 1
  end

  def test_it_finds_invoice_items
    assert merchant.respond_to? :get_invoice_items
    assert merchant.get_invoice_items
    assert_equal 1, merchant.get_invoice_items.length
  end

  def test_it_finds_revenue
    assert merchant.revenue
    assert_equal BigDecimal('1856.94'), merchant.revenue
  end

  def test_it_finds_favorite_customer
    assert merchant.favorite_customer
    assert_equal Customer, merchant.favorite_customer.class
    assert_equal "Mariah", merchant.favorite_customer.first_name
  end
end
