require './test/test_helper'

class CustomerTest < Minitest::Test
  def entry
    {
      id: 1,
      first_name: "Robb",
      last_name: "Stark",
      created_at: "10 oclock",
      updated_at: "11 oclock"
    }
  end

  def test_customer_attributes
    customer = Customer.new(entry)

    assert_equal 1, customer.id
    assert_equal "Robb", customer.first_name
    assert_equal "Stark", customer.last_name
    assert_equal "10 oclock", customer.created_at
    assert_equal "11 oclock", customer.updated_at
  end
end
