require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should save a valid user" do
    user = User.new(email: "foo@example.com", password: "password")
    assert user.save
  end
end
