require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  attr_reader :engine
  
  def setup
    @engine = SalesEngine.new('./test/fixtures')
  end
  
  def test_it_creates_merchant_repo
    assert engine.merchant_repository
  end
  
  def test_it_creates_customer_repo
    assert engine.customer_repository
  end
  
  def test_it_creates_invoice_item_repo
    assert engine.invoice_item_repository
  end
  
  def test_it_creates_invoice_repo
    assert engine.invoice_repository
  end
  
  def test_it_creates_item_repo
    assert engine.item_repository
  end
  
  def test_it_creates_transaction_repo
    assert engine.transaction_repository
  end
end
