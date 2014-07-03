require './test/test_helper'

class ItemRepositoryTest < Minitest::Test
  attr_reader :item_repository

  def setup
    engine = SalesEngine.new('./test/fixtures/')
    @item_repository = engine.item_repository
  end

  # figure out if these tests are good
  def test_it_loads_Item_objects
    assert item_repository.items.length >= 10
  end

  def test_it_finds_by_id
    results = item_repository.find_by_id(1)
    assert_equal 75107, results.unit_price
  end

  def test_it_finds_by_name
    results = item_repository.find_by_name('Item Qui Esse')
    assert_equal results.id, 1

    results = item_repository.find_by_name('Item Qui Esse')
    refute_equal results.id, 2
  end
  
  def test_it_finds_by_unit_price
    results = item_repository.find_by_unit_price(75107)
    assert_equal results.id, 1

    results = item_repository.find_by_unit_price(75107)
    refute_equal results.id, 2
  end
  
  def test_it_finds_by_merchant_id
    results = item_repository.find_by_merchant_id(1)
    assert_equal results.id, 1

    results = item_repository.find_by_merchant_id(1)
    refute_equal results.id, 2
  end
  
  def test_it_finds_all_by_name
    results = item_repository.find_all_by_name('Item Qui Esse')
    assert_equal results[0].id, 1

    results = item_repository.find_all_by_name('Item Qui Esse')
    refute_equal results[0].id, 2
  end
  
  def test_it_finds_all_by_unit_price
    results = item_repository.find_all_by_unit_price(75107)
    assert_equal results[0].id, 1

    results = item_repository.find_all_by_unit_price(75107)
    refute_equal results[0].id, 2
  end
  
  def test_it_finds_all_by_merchant_id
    results = item_repository.find_all_by_merchant_id(1)
    assert_equal results[0].id, 1

    results = item_repository.find_all_by_merchant_id(1)
    refute_equal results[0].id, 2
  end
end
