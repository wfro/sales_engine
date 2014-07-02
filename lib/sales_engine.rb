require_relative 'customer_repository'
require_relative 'invoice_item_repository'
require_relative 'invoice_repository'
require_relative 'item_repository'
require_relative 'customer_repository'
require_relative 'transaction_repository'
require_relative 'merchant_repository'

class SalesEngine
  attr_reader :data

  def initialize(data='./data')
    @data = data
  end

  def customer_repository(filename="#{data}/customers.csv")
    @customer_repository ||= CustomerRepository.new(filename, self)
  end

  def invoice_repository(filename= "#{data}/invoices.csv")
    @invoice_repository ||= InvoiceRepository.load(filename, self)
  end

  def invoice_item_repository(filename= "#{data}/invoice_items.csv")
    @invoice_item_repository ||= InvoiceItemRepository.load(filename, self)
  end

  def merchant_repository(filename= "#{data}/merchants.csv")
    @merchant_repository ||= MerchantRepository.new(filename, self)
  end

  def item_repository(filename= "#{data}/items.csv")
    @item_repository ||= ItemRepository.new(filename, self)
  end

  def transaction_repository(filename= "#{data}/transactions.csv")
    @transaction_repository ||= TransactionRepository.new(filename, self)
  end
end
