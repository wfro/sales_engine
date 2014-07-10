require './test/test_helper'

class MerchantTest < Minitest::Test
  attr_reader :merchant, :engine

  def setup
    @engine = SalesEngine.new('./test/fixtures')
    @merchant = engine.merchant_repository.merchants[0]
  end

  def test_attributes
    assert_equal 1, @merchant.id
    assert_equal "Schroeder-Jerde", @merchant.name
  end
  
  def test_dates_are_converted_to_Date_objects
    assert merchant.created_at
    assert merchant.updated_at
    assert_equal Date, merchant.created_at.class
    assert_equal Date, merchant.updated_at.class
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
    assert merchant.respond_to? :invoice_items
    assert merchant.invoice_items
    assert_equal 3, merchant.invoice_items.length
  end

  def test_it_finds_revenue
    assert merchant.revenue
    assert_equal BigDecimal('2785.41'), merchant.revenue
  end

  def test_it_finds_revenue_by_date
    date =  Date.parse("06 Mar 2012")
    assert_equal BigDecimal('2785.41'), merchant.revenue(date)
  end

  def test_it_finds_favorite_customer
    assert merchant.favorite_customer
    assert_equal Customer, merchant.favorite_customer.class
    assert_equal "Mariah", merchant.favorite_customer.first_name
  end

  def test_it_finds_paid_invoices
    assert merchant.paid_invoices

    assert_equal 1, merchant.paid_invoices.length
    refute_equal 2, merchant.paid_invoices.length
  end
end
