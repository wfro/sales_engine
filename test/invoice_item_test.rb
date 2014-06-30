require './test/test_helper'

class InvoiceItemTest < Minitest::Test
  
  def entry
    {
    id: '1',
    item_id: '539',
    invoice_id: '1',
    quantity: '5',
    unit_price: '13635',
    created_at: 'time',
    updated_at: 'time2'
    }
  end
  
  def test_attributes
    invoice_item = InvoiceItem.new(entry)
    assert_equal '1', invoice_item.id
    assert_equal '539', invoice_item.item_id
    assert_equal '1', invoice_item.invoice_id
    assert_equal '5', invoice_item.quantity
    assert_equal '13635', invoice_item.unit_price
    assert_equal 'time', invoice_item.created_at
    assert_equal 'time2', invoice_item.updated_at
  end
end
