require './test/test_helper'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant_repository
  
  def setup
    filename = './test/fixtures/merchants.csv'
    @merchant_repository = MerchantRepository.load(filename)
  end
  
  def test_it_loads_merchant_objects
    assert_equal "Schroeder-Jerde", merchant_repository.merchants[0].name
  end
  
  def test_returns_all_merchants
    assert merchant_repository.all.length >= 10
  end
end
