require './test/test_helper'

class ItemRepositoryTest < Minitest::Test
  attr_reader :item_repository

  def setup
    filename = './test/fixtures/items.csv'
    @item_repository = ItemRepository.load(filename)
  end

  # figure out if these tests are good
  def test_it_loads_Item_objects
    assert_equal "Item Qui Esse", item_repository.items[0].name
  end

  def test_it_finds_by_name
    results = item_repository.find_by_name('Item Qui Esse')
    assert_equal results.id, "1"

    results = item_repository.find_by_name('Item Qui Esse')
    refute_equal results.id, "2"
  end
  
  def test_it_finds_by_unit_price
    results = item_repository.find_by_unit_price('75107')
    assert_equal results.id, "1"

    results = item_repository.find_by_unit_price('75107')
    refute_equal results.id, "2"
  end
  
  def test_it_finds_by_merchant_id
    results = item_repository.find_by_merchant_id('1')
    assert_equal results.id, "1"

    results = item_repository.find_by_merchant_id('1')
    refute_equal results.id, "2"
  end
  
  def test_it_finds_all_by_name
    results = item_repository.find_all_by_name('Item Qui Esse')
    assert_equal results[0].id, "1"

    results = item_repository.find_all_by_name('Item Qui Esse')
    refute_equal results[0].id, "2"
  end
  
  def test_it_finds_all_by_unit_price
    results = item_repository.find_all_by_unit_price('75107')
    assert_equal results[0].id, "1"

    results = item_repository.find_all_by_unit_price('75107')
    refute_equal results[0].id, "2"
  end
  
  def test_it_finds_all_by_merchant_id
    results = item_repository.find_all_by_merchant_id('1')
    assert_equal results[0].id, "1"

    results = item_repository.find_all_by_merchant_id('1')
    refute_equal results[0].id, "2"
  end
end
