require './test/test_helper'

class TransactionRepositoryTest < Minitest::Test
  def setup
    filename = './test/fixtures/transactions.csv'
    @transaction_repository = TransactionRepository.load(filename)
  end
  
  def test_it_loads_transaction_objects
    assert_equal "4654405418249632", @transaction_repository.transactions[0].credit_card_number
  end
end
