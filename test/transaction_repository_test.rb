require './test/test_helper'

class TransactionRepositoryTest < Minitest::Test
  attr_reader :transaction_repository

  def setup
    filename = './test/fixtures/transactions.csv'
    @transaction_repository = TransactionRepository.load(filename)
  end
  
  def test_it_loads_transaction_objects
    assert_equal "4654405418249632", transaction_repository.transactions[0].credit_card_number
  end
  
  def test_returns_all_transactions
    assert transaction_repository.all.length >= 10
  end
end
