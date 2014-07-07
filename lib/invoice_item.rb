class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :engine

  def initialize(data, invoice_item_repo_ref)
    @id                    = data[:id].to_i
    @item_id               = data[:item_id].to_i
    @invoice_id            = data[:invoice_id].to_i
    @quantity              = data[:quantity].to_i
    @unit_price            = BigDecimal.new(data[:unit_price].to_i)
    @created_at            = data[:created_at]
    @updated_at            = data[:updated_at]
    @engine                = invoice_item_repo_ref.engine
  end

  def invoice
    engine.invoice_repository.find_by_id(invoice_id)
  end

  def item
    engine.item_repository.find_by_id(item_id)
  end
end
