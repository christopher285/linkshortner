# test/models/link_test.rb
require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  

  test "should not be valid without original_url" do
    link = Link.new(lookup_code: 'abc123')
    assert_not link.valid?
    assert_includes link.errors[:original_url], "can't be blank"
  end

  test "should not be valid without lookup_code" do
    link = Link.new(original_url: 'http://example.com')
    assert_not link.valid?
    assert_includes link.errors[:lookup_code], "can't be blank"
  end

  test "should not be valid with duplicate lookup_code" do
    existing_link = links(:valid_link) # Replace with your fixture or factory setup
    link = Link.new(original_url: 'http://example.com', lookup_code: existing_link.lookup_code)
    assert_not link.valid?
    assert_includes link.errors[:lookup_code], "has already been taken"
  end

  test "should not be valid with invalid original_url format" do
    link = Link.new(original_url: 'invalid_url', lookup_code: 'abc123')
    assert_not link.valid?
    assert_includes link.errors[:original_url], "Invalid URL format"
  end

  test "should provide a shortened URL" do
    link = Link.new(original_url: 'http://example.com', lookup_code: 'abc123')
    assert_equal "http://localhost:3000/abc123", link.shortened_url
  end
end
