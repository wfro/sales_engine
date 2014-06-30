require './test/test_helper'

class InvoiceTest < Minitest::Test
  def entry
    {
      id: 1,
      customer_id: 25,
      merchant_id: 30,
      status: 'shipped',
      created_at: '1 oclock',
      updated_at: '2 oclock'
    }
  end

  def test_invoice_attributes
    invoice = Invoice.new(entry)

    assert_equal 1, invoice.id
    assert_equal 25, invoice.customer_id
    assert_equal 30, invoice.merchant_id
    assert_equal 'shipped', invoice.status
    assert_equal '1 oclock', invoice.created_at
    assert_equal '2 oclock', invoice.updated_at
  end
end
