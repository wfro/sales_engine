require './test/test_helper'

class TransactionTest < Minitest::Test
  attr_reader :transaction

  def setup
    engine = SalesEngine.new('./test/fixtures/')
    @transaction = engine.transaction_repository.transactions[0]
  end

  def test_dates_are_converted_to_Date_objects
    assert transaction.created_at
    assert transaction.updated_at
    assert_equal Date, transaction.created_at.class
    assert_equal Date, transaction.updated_at.class
  end

  def test_attributes
    assert_equal 1, transaction.id
    assert_equal 1, transaction.invoice_id
    assert_equal '4654405418249632', transaction.credit_card_number
    assert_equal nil, transaction.credit_card_expiration_date
    assert_equal 'success', transaction.result
  end

  def test_it_returns_the_corresponding_invoice
    assert transaction.respond_to? "invoice"
    assert transaction.invoice
    assert_equal 1, transaction.invoice.id
  end

  def test_it_finds_the_corresponding_merchant
    assert_equal "Balistreri, Schaefer and Kshlerin", transaction.merchant.name
  end
end
