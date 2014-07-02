require './test/test_helper'

class CustomerTest < Minitest::Test
  def setup
    engine = SalesEngine.new('./test/fixtures')
    @customer = engine.customer_repository.customers[0]
  end

  def test_customer_attributes
    assert_equal 1, @customer.id
    assert_equal "Joey", @customer.first_name
    assert_equal "Ondricka", @customer.last_name
  end
end
