class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(data, invoice_item_repo_ref)
    @id                    = data[:id].to_i
    @item_id               = data[:item_id].to_i
    @invoice_id            = data[:invoice_id].to_i
    @quantity              = data[:quantity].to_i
    @unit_price            = data[:unit_price].to_i
    @created_at            = data[:created_at]
    @updated_at            = data[:updated_at]
    @invoice_item_repo_ref = invoice_item_repo_ref
  end

  # def invoice
  #   # returns an instance of Invoice associated with this object
  # end
end
