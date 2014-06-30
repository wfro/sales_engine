require './test/test_helper'

class CustomerRepositoryTest < Minitest::Test

  attr_reader :customer_repository

  def setup
    filename = './test/fixtures/customers.csv'
    @customer_repository = CustomerRepository.load(filename)
  end

  def test_it_loads_customer_objects
    assert_equal "Joey", customer_repository.customers[0].first_name
  end

  def test_returns_all_customers
    assert customer_repository.all.length >= 10
  end
end
