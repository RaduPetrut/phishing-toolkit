require 'test_helper'

class CampaignTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:george)
  	@template = @user.templates.build(name: "Test Template")
  	@campaign = @user.campaigns.build(name: "Test Campaign", 
  										smtp_server: "test.smtp", 
  										from: "me", 
  										from_alias: "me me me",
  										subject: "give me all your money",
  										template_id: 1,
  										victims: "aaa@sad.com eee@sad.err")
  end

  test "should be valid" do
    assert @campaign.valid?
  end

  test "user id should be present" do
    @campaign.user_id = nil
    assert_not @campaign.valid?
  end

  test "name should be present" do
    @campaign.name = "   "
    assert_not @campaign.valid?
  end

  test "name should be at most 30 characters" do
    @campaign.name = "a" * 31
    assert_not @campaign.valid?
  end
  
  test "smtp_server should be present" do
    @campaign.smtp_server = "   "
    assert_not @campaign.valid?
  end

  test "smtp_server should be at most 30 characters" do
    @campaign.smtp_server = "a" * 31
    assert_not @campaign.valid?
  end

  test "from should be present" do
    @campaign.from = "   "
    assert_not @campaign.valid?
  end

  test "from should be at most 30 characters" do
    @campaign.from = "a" * 31
    assert_not @campaign.valid?
  end

  test "from_alias should be present" do
    @campaign.from_alias = "   "
    assert_not @campaign.valid?
  end

  test "from_alias should be at most 30 characters" do
    @campaign.from_alias = "a" * 31
    assert_not @campaign.valid?
  end

  test "subject should be present" do
    @campaign.subject = "   "
    assert_not @campaign.valid?
  end

  test "subject should be at most 80 characters" do
    @campaign.subject = "a" * 81
    assert_not @campaign.valid?
  end

  test "template_id should be present" do
    @campaign.template_id = nil
    assert_not @campaign.valid?
  end

  test "victims should be present" do
    @campaign.victims = "		"
    assert_not @campaign.valid?
  end

  test "victims should be at most 1000 characters" do
    @campaign.victims = "a" * 1001
    assert_not @campaign.valid?
  end

end
