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

  def test_it_finds_by_id
    result = customer_repository.find_by_id('1')
    assert_equal "Joey", result.first_name
  end

  def test_it_finds_by_first_name
    result = customer_repository.find_by_first_name('Joey')
    assert_equal 'Ondricka', result.last_name
  end

  def test_it_finds_by_last_name
    result = customer_repository.find_by_last_name('Ondricka')
    assert_equal '1', result.id
  end

  def test_it_finds_all_by_id
    result = customer_repository.find_all_by_id('1')
    assert_equal "Joey", result[0].first_name
  end

  def test_it_finds_all_by_first_name
    result = customer_repository.find_all_by_first_name('Joey')
    assert_equal 'Ondricka', result[0].last_name
  end

  def test_it_finds_all_by_last_name
    result = customer_repository.find_all_by_last_name('Ondricka')
    assert_equal '1', result[0].id
  end  
end
