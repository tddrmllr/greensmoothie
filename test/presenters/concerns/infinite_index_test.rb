require 'test_helper'

class InfiniteIndexTest < ViewTest
  attr_accessor :presenter

  setup do
    @presenter = TestPresenter.new(params: { controller: 'nutrients', page: 1 }, per: 5)
  end

  test 'ids should return ids of the index' do
    assert_equal Nutrient.all.map(&:id), presenter.ids
  end

  test 'index should be a paginated kaminari array' do
    assert_kind_of Kaminari::PaginatableArray, presenter.index
  end

  test 'index should contain number of records in the per attribute' do
    presenter.per = 1
    assert_equal 1, presenter.index.count
  end

  test 'index should return the correct page of records' do
    presenter.per = 1
    presenter.page = 2
    assert_equal nutrients(:iron), presenter.index.first
  end

  test 'ransack should return ransack search object' do
    assert_kind_of Ransack::Search, presenter.ransack
  end

  test 'search should return filtered results based on the query' do
    presenter.query = 'iron'
    assert_includes presenter.search, nutrients(:iron)
  end

  test 'search_terms should raise not implemented error' do
    assert_raises NotImplementedError do
      presenter.search_terms
    end
  end

  test 'total_pages should return the correct number of pages' do
    presenter.per = 1
    assert_equal 3, presenter.total_pages
    presenter.per = 2
    assert_equal 2, presenter.total_pages
  end

  private

  class TestPresenter < Presenter
    include InfiniteIndex
  end
end
