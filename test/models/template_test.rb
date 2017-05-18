require 'test_helper'

class TemplateTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:george)
  	@template = @user.templates.build(name: "Test Template")
  end

  test "should be valid" do
    assert @template.valid?
  end

  test "user id should be present" do
    @template.user_id = nil
    assert_not @template.valid?
  end

  test "name should be present" do
    @template.name = "   "
    assert_not @template.valid?
  end

  test "name should be at most 30 characters" do
    @template.name = "a" * 31
    assert_not @template.valid?
  end

  test "description can be empty" do
    @template.description = ""
    assert @template.valid?
  end

  test "description should be at most 30 characters if present" do
    @template.description = "a" * 141
    assert_not @template.valid?
  end

  test "order should be most recent first" do
    assert_equal templates(:most_recent), Template.first
  end

end
