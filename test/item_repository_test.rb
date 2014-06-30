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
end
