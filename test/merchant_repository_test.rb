require './test/test_helper'

class MerchantRepositoryTest < Minitest::Test
  def setup
    filename = './test/fixtures/merchants.csv'
    @merchant_repository = MerchantRepository.load(filename)
  end
  
  def test_it_loads_merchant_objects
    assert_equal "Schroeder-Jerde", @merchant_repository.merchants[0].name
  end
end
