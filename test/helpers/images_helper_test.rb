require 'test_helper'

class ImagesHelperTest < HelperTest
  include ImagesHelper


  attr_accessor :imageable

  setup do
    @imageable = ingredients(:kale)
  end

  test 'gradient_image should have gradient image inside the div' do
    html = Nokogiri::HTML.fragment(gradient_image(imageable)).children.first
    assert_equal '/images/white-transparent-gradient.png', html.children.first.attr('src')
  end

  test 'gradient_image should use fallback image in background if resource has no image' do
    imageable.stub :image?, false do
      html = Nokogiri::HTML.fragment(gradient_image(imageable)).children.first
      assert_equal 'background-image: url(/ingredient.png)', html.attr('style')
    end
  end

  test 'gradient_image should use resource image in background if resource has image' do
    imageable.stub :image, ImageDouble do
      html = Nokogiri::HTML.fragment(gradient_image(imageable)).children.first
      assert_equal 'background-image: url(/image.png)', html.attr('style')
    end
  end

  test 'thumbnail_image_path should return resource image url if present' do
    imageable.stub :image, ImageDouble do
      assert_equal '/image.png', thumbnail_image_path(imageable)
    end
  end

  test 'thumbnail_image_path should return fallback image if resource has no image' do
    imageable.stub :image?, false do
      assert_equal '/ingredient.png', thumbnail_image_path(imageable)
    end
  end
end
