require './test/test_helper'

class TransactionTest < Minitest::Test
  attr_reader :transaction

  def setup
    engine = SalesEngine.new('./test/fixtures/')
    @transaction = engine.transaction_repository.transactions[0]
  end

  def test_attributes
    assert_equal 1, transaction.id
    assert_equal 1, transaction.invoice_id
    assert_equal 4654405418249632, transaction.credit_card_number
    assert_equal nil, transaction.credit_card_expiration_date
    assert_equal 'success', transaction.result
  end
end
