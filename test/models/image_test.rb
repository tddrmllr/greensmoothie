require 'test_helper'

class ImageTest < UnitTest
  attr_accessor :image

  setup do
    @image = images(:sample_image)
  end

  test 'cropping? is true if all coords are set' do
    image.assign_attributes(crop_x: 9, crop_y: 9, crop_h: 9, crop_w: 9)
    assert image.cropping?
  end

  test 'cropping? is false if any coords are missing' do
    image.assign_attributes(crop_x: 9, crop_y: 9, crop_h: 9, crop_w: nil)
    refute image.cropping?
  end

  test 'image_geometry' do
    Paperclip::Geometry.stub :from_file, GeometryDouble.new do
      assert_equal 262, image.image_geometry.width
      assert_equal 262, image.image_geometry.height
    end
  end

  test 'imageable' do
    image.imageable = recipes(:kale_smoothie)
    image.save
    assert_kind_of Recipe, image.imageable
  end

  test 'upload image from url' do
    image.image_url = 'http://s1.postimg.org/s7zghxtzz/logo.png'
    image.save
    assert_equal 'logo.png', image.image_file_name
  end
end
