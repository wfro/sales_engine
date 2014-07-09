require 'csv'
require 'time'
require_relative 'transaction'

class TransactionRepository
  attr_reader :transactions,
              :engine

  def initialize(filename, engine)
    @engine = engine
    from_csv(filename)
  end

  def from_csv(filename)
    rows = CSV.open(filename, headers: true, header_converters: :symbol)
    @transactions = rows.map { |row| Transaction.new(row, self) }
  end

  def create(charge_data)
    new_transaction = charge_data

    new_transaction[:id]         = all.length + 1
    new_transaction[:created_at] = Time.new.to_s
    new_transaction[:updated_at] = Time.new.to_s

    all << Transaction.new(new_transaction, self)
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

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end
end
