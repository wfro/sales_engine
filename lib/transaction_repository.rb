require 'csv'
require_relative 'transaction'

class TransactionRepository
  def self.load(filename, engine)
    rows = CSV.open(filename, headers: true, header_converters: :symbol)
    transactions = rows.map { |row| Transaction.new(row) }
    new(transactions, engine)
  end
  
  attr_reader :transactions
              :engine
  
  def initialize(transactions, engine)
    @transactions = transactions
    @engine = engine
  end
    
  def all
    transactions
  end
  
  def random
    transactions.sample
  end
  
  def find_by_id(match)
    transactions.detect { |t| t.id == match }
  end

  def find_by_invoice_id(match)
    transactions.detect { |t| t.invoice_id == match }
  end

  def find_by_credit_card_number(match)
    transactions.detect { |t| t.credit_card_number == match }
  end

  def find_by_result(match)
    transactions.detect { |t| t.result.downcase == match.downcase }
  end

  def find_all_by_id(match)
    transactions.select { |t| t.id == match }
  end

  def find_all_by_invoice_id(match)
    transactions.select { |t| t.invoice_id == match }
  end

  def find_all_by_credit_card_number(match)
    transactions.select { |t| t.credit_card_number == match }
  end

  def find_all_by_result(match)
    transactions.select { |t| t.result.downcase == match.downcase }
  end
end
