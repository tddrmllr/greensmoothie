require 'test_helper'

class UpdateImageTest < ControllerTest
  class UpdateImageController < ApplicationController
    include UpdateImage

    def controller_name
      'ingredients'
    end

    def create
      @ingredient = Ingredient.find_by_name('Kale')
      render nothing: true
    end

    def update
      @ingredient = Ingredient.find_by_name('Beets')
      render nothing: true
    end
  end

  tests UpdateImageController

  test 'update_image' do
    imageable = ingredients(:kale)
    image = images(:sample_image)

    with_routing do |map|
      map.draw do
        resources :update_images, controller: 'update_image_test/update_image'
      end
      post :create, ingredient: { image_token: 'sample_image_token' }
      assert_equal imageable.reload.image, image
    end
  end

  test 'cleanup_images' do
    imageable = ingredients(:beets)
    imageable.image.update_column :created_at, Time.now - 2.days
    image = images(:sample_image)
    image.update_columns(created_at: Time.now - 1.day, imageable_id: imageable.id, imageable_type: imageable.class.name)

    with_routing do |map|
      map.draw do
        resources :update_images, controller: 'update_image_test/update_image'
      end

      put :update, id: imageable.id, ingredient: { image_token: 'sample_image_token' }
      assert_equal imageable.reload.image, image
    end
  end
end
