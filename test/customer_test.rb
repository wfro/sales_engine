require './test/test_helper'

class CustomerTest < Minitest::Test
  attr_reader :customer

  def setup
    engine = SalesEngine.new('./data')
    @customer = engine.customer_repository.customers[0]
  end

  def test_customer_attributes
    assert_equal 1, @customer.id
    assert_equal "Joey", @customer.first_name
    assert_equal "Ondricka", @customer.last_name
  end

  def test_converts_dates_to_Date_objects

  end
  
  def test_it_retrieves_invoices_for_a_customer
    assert customer.respond_to? :invoices
    assert customer.invoices
    assert customer.invoices.length >= 8
  end

  def test_it_retrieves_transactions_for_a_customer
    assert customer.respond_to? :transactions
    assert customer.transactions
    assert customer.transactions.length >= 7
  end

  def test_it_retrieves_favorite_merchant
    assert customer.respond_to? :favorite_merchant
    assert customer.favorite_merchant
    assert_equal Merchant, customer.favorite_merchant.class
    assert_equal "Balistreri, Schaefer and Kshlerin", customer.favorite_merchant.name
  end
end
