require 'csv'
require_relative 'transaction'

class TransactionRepository
  def self.load(filename='./data/transactions.csv')
    rows = CSV.open(filename, headers: true, header_converters: :symbol)
    transactions = rows.map { |row| Transaction.new(row) }
    new(transactions)
  end
  
  attr_reader :transactions
  
  def initialize(transactions)
    @transactions = transactions
  end
    
  def all
    transactions
  end
  
  def random
    transactions.sample
  end
  
  def find_by_id(match)
    transactions.detect { |t| t.id.downcase == match.downcase }
  end

  def find_by_invoice_id(match)
    transactions.detect { |t| t.invoice_id.downcase == match.downcase }
  end

  def find_by_credit_card_number(match)
    transactions.detect { |t| t.credit_card_number.downcase == match.downcase }
  end

  def find_by_result(match)
    transactions.detect { |t| t.result.downcase == match.downcase }    
  end

  def find_all_by_id(match)
    transactions.select { |t| t.id.downcase == match.downcase }
  end

  def find_all_by_invoice_id(match)
    transactions.select { |t| t.invoice_id.downcase == match.downcase }
  end

  def find_all_by_credit_card_number(match)
    transactions.select { |t| t.credit_card_number.downcase == match.downcase }
  end

  def find_all_by_result(match)
    transactions.select { |t| t.result.downcase == match.downcase }    
  end
end
