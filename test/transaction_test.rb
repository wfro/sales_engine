require './test/test_helper'

class TransactionTest < Minitest::Test
  
  def entry
    {
    id: '1',
    invoice_id: '1',
    credit_card_number: '4654405418249632',
    credit_card_expiration_date: '',
    result: 'success',
    created_at: 'time',
    updated_at: 'time2'
    }
  end
  
  def test_attributes
    transaction = Transaction.new(entry)
    assert_equal 1, transaction.id
    assert_equal 1, transaction.invoice_id
    assert_equal 4654405418249632, transaction.credit_card_number
    assert_equal '', transaction.credit_card_expiration_date
    assert_equal 'success', transaction.result
    assert_equal 'time', transaction.created_at
    assert_equal 'time2', transaction.updated_at
  end
end
