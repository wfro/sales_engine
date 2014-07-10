require './test/test_helper'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant_repository

  def setup
    engine = SalesEngine.new('./test/fixtures')
    @merchant_repository = engine.merchant_repository
  end

  def test_it_loads_merchant_objects
    assert_equal "Schroeder-Jerde", merchant_repository.merchants[0].name
  end

  def test_returns_all_merchants
    assert merchant_repository.all.length >= 10
  end

  def test_find_by_id
    results = merchant_repository.find_by_id(1)
    assert_equal "Schroeder-Jerde", results.name

    results = merchant_repository.find_by_id(2)
    refute_equal "Schroeder-Jerde", results.name
  end

  def test_find_by_name
    results = merchant_repository.find_by_name("Schroeder-Jerde")
    assert_equal 1, results.id

    results = merchant_repository.find_by_name('Schroeder-Jerde')
    refute_equal 2, results.id
  end

  def test_find_all_by_id
    results = merchant_repository.find_all_by_id(1)
    assert_equal "Schroeder-Jerde", results[0].name

    results = merchant_repository.find_all_by_id(2)
    refute_equal "Schroeder-Jerde", results[0].name
  end

  def test_find_all_by_name
    results = merchant_repository.find_all_by_name("Schroeder-Jerde")
    assert_equal 1, results[0].id

    results = merchant_repository.find_all_by_name('Schroeder-Jerde')
    refute_equal 2, results[0].id
  end

  def test_it_finds_revenue_for_all_merchants_by_date
    date = Date.parse("25 Mar 2012")
    assert_equal BigDecimal("21067.77"), merchant_repository.revenue(date)
  end
end
