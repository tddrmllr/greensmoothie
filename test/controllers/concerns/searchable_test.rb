require 'test_helper'

class SearchableTest < ControllerTest
  class SearchableController < ApplicationController
    include Searchable

    def controller_name
      'ingredients'
    end

    def index
      true
    end
  end

  tests SearchableController

  test 'typeahead search' do
    with_routing do |map|
      map.draw do
        resources :searchable, controller: 'searchable_test/searchable'
      end
      xhr :get, :index, typeahead: 'true', q: 'Beets'
      assert_equal 'Beets', json_response.first['name']
    end
  end

  test 'js search' do
    with_routing do |map|
      map.draw do
        resources :searchable, controller: 'searchable_test/searchable'
      end
      @controller.stub :render, true do
        xhr :get, :index
        assert_response :success
      end
    end
  end
end
