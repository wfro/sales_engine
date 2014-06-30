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
  
  # def find_by_X(match)
  #   # where X is some attribute, returns a single instance whose X attribute case-insensitive attribute matches the match parameter. For instance, Customer.find_by_first_name("Mary") could find a Customer with the first name attribute "Mary" or "mary" but not "Mary Ellen".
  # end
  #
  # def find_all_by_X(match)
  #   #  works just like find_by_X except it returns a collection of all matches. If there is no match, it returns an empty Array.
  # end
end
