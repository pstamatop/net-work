require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:panagiota)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { firstName:  "",
    										  lastName: "",
                                              email: "foo@invalid",
                                              phone: "32544",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'users/edit'
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    firstName  = "Foo"
    lastName = "Bar"
    email = "foo@bar.com"
    phone = "210-3339111"
    patch user_path(@user), params: { user: { firstName:  firstName,
    										  lastName: lastName,
                                              email: email,
                                              phone: phone,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal firstName,  @user.firstName
    assert_equal lastName,  @user.lastName
    assert_equal email, @user.email
  end
end
