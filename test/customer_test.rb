require './test/test_helper'

class CustomerTest < Minitest::Test
  attr_reader :customer

  def setup
    engine = SalesEngine.new('./test/fixtures')
    @customer = engine.customer_repository.customers[0]
  end

  def test_customer_attributes
    assert_equal 1, @customer.id
    assert_equal "Joey", @customer.first_name
    assert_equal "Ondricka", @customer.last_name
  end

  def test_converts_dates_to_Date_objects
    assert customer.created_at
    assert customer.updated_at
    assert Date, customer.created_at.class
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

  def test_it_retrieves_pending_invoices
    assert customer.respond_to? :pending_invoices
    assert customer.pending_invoices
    assert_equal Array, customer.pending_invoices.class
    assert_equal Invoice, customer.pending_invoices.first.class
    assert_equal 78, customer.pending_invoices.first.merchant_id
  end
end
