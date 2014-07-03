require './test/test_helper'

class TransactionRepositoryTest < Minitest::Test
  attr_reader :transaction_repository

  def setup
    engine = SalesEngine.new('./test/fixtures/')
    @transaction_repository = engine.transaction_repository
  end

  def test_it_loads_transaction_objects
    assert_equal 4654405418249632, transaction_repository.transactions[0].credit_card_number
  end

  def test_returns_all_transactions
    assert transaction_repository.all.length >= 10
  end

  def test_finds_by_id
    result = transaction_repository.find_by_id(1)
    assert_equal 4654405418249632, result.credit_card_number
  end

  def test_finds_by_invoice_id
    result = transaction_repository.find_by_invoice_id(1)
    assert_equal 4654405418249632, result.credit_card_number
  end

  def test_finds_by_credit_card_number
    result = transaction_repository.find_by_credit_card_number(4654405418249632)
    assert_equal 1, result.id
  end

  def test_finds_by_result
    result = transaction_repository.find_by_result('success')
    assert_equal 1, result.id
  end

  def test_finds_all_by_id
    result = transaction_repository.find_all_by_id(1)
    assert_equal 4654405418249632, result[0].credit_card_number
  end
  
  def test_finds_all_by_invoice_id
    result = transaction_repository.find_all_by_invoice_id(1)
    assert_equal 4654405418249632, result[0].credit_card_number
  end

  def test_finds_all_by_credit_card_number
    result = transaction_repository.find_all_by_credit_card_number(4654405418249632)
    assert_equal 1, result[0].id
  end

  def test_finds_all_by_result
    result = transaction_repository.find_all_by_result('success')
    assert_equal 1, result[0].id
  end
end
