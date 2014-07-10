require './test/test_helper'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :customer_repository

  def setup
    engine = SalesEngine.new('./test/fixtures')
    @customer_repository = engine.customer_repository
  end

  def test_it_loads_customer_objects
    assert_equal "Joey", customer_repository.customers[0].first_name
  end

  def test_returns_all_customers
    assert customer_repository.all.length >= 10
  end

  def test_it_finds_by_id
    result = customer_repository.find_by_id(1)
    assert_equal "Joey", result.first_name
  end

  def test_it_finds_by_first_name
    result = customer_repository.find_by_first_name('Joey')
    assert_equal 'Ondricka', result.last_name
  end

  def test_it_finds_by_last_name
    result = customer_repository.find_by_last_name('Ondricka')
    assert_equal 1, result.id
  end

  def test_it_finds_all_by_id
    result = customer_repository.find_all_by_id(1)
    assert_equal "Joey", result[0].first_name
  end

  def test_it_finds_all_by_first_name
    result = customer_repository.find_all_by_first_name('Joey')
    assert_equal 'Ondricka', result[0].last_name
  end

  def test_it_finds_all_by_last_name
    result = customer_repository.find_all_by_last_name('Ondricka')
    assert_equal 1, result[0].id
  end

  def test_it_finds_customer_who_purchased_most_items
    assert customer_repository.respond_to? :most_items
    assert customer_repository.most_items
    assert customer_repository.most_items.class == Customer
    assert_equal 'Ondricka', customer_repository.most_items.last_name
  end


  def test_it_finds_most_valuable_customer
    assert customer_repository.respond_to? :most_revenue
    assert customer_repository.most_revenue
    assert_equal Customer, customer_repository.most_revenue.class
    assert_equal 'Ondricka', customer_repository.most_revenue.last_name
  end
end
