require 'test_helper'

class ImagesControllerTest < ControllerTest
  tests ImagesController

  attr_accessor :image

  setup do
    @image = images(:sample_image)
  end

  test 'successful create' do
    xhr :post, :create, image: valid_image_params
    assert_response :success
    assert_template :create
    assert_equal 'Photo updated successfully.', flash[:success]
  end

  test 'failed create' do
    xhr :post, :create, image: { token: 'some_token' }
    assert_response :success
    assert_template :create
    assert_equal 'Invalid image or URL.', flash[:error]
  end

  test 'successful update' do
    xhr :put, :update, id: image.id, image: valid_image_params
    assert_response :success
    assert_template :update
    assert_equal 'Photo updated successfully.', flash[:success]
  end

  test 'failed update' do
    xhr :put, :update, id: image.id, image: invalid_image_params
    assert_response :success
    assert_template :update
    assert_equal 'Invalid image or URL.', flash[:error]
  end

  test 'edit' do
    Paperclip::Geometry.stub :from_file, GeometryDouble.new do
      xhr :get, :edit, id: image.id
      assert_response :success
      assert_template 'layouts/modal'
    end
  end

  private

  def invalid_image_params
    { image: fixture_file_upload('files/sample_file.png') }
  end

  def valid_image_params
    { image: fixture_file_upload('files/sample_file.png', 'image/png') }
  end
end
