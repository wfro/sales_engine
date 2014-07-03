require './test/test_helper'

class InvoiceTest < Minitest::Test
  attr_reader :invoice

  def setup
    engine = SalesEngine.new('./test/fixtures')
    @invoice = engine.invoice_repository.invoices[0]
  end

  def test_invoice_attributes
    assert_equal 1, invoice.id
  end
end
