# test/controllers/links_controller_test.rb
require 'test_helper'

class LinksControllerTest < ActionDispatch::IntegrationTest
 

  

  test "should create link and redirect to root_path on successful creation" do
    assert_difference('Link.count') do
      post links_path, params: { link: { original_url: 'http://example.com' } }
    end

    assert_redirected_to root_path
    assert_equal 'Link created successfully!', flash[:notice]
  end

  test "should not create link and render home/index on unsuccessful creation" do
    post links_path, params: { link: { original_url: 'www.google.com' } }

    assert_response :success
    assert_template 'home/index'
    assert_equal 'Invalid URL format. Please enter a valid URL.', flash[:alert]
  end
end
