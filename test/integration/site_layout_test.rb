require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contacts_path
    assert_select "a[href=?]", login_path
    get contacts_path
    assert_select "title", full_title("Contacts")
    get signup_path
    assert_select "title", full_title("Sign up")
    get about_path
    assert_select "title", full_title("About")
    get help_path
    assert_select "title", full_title("Help")

    log_in_as @user
    get root_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", logout_path
    get user_path (@user)
    assert_select "title", full_title("#{@user.name}")
    get edit_user_path (@user)
    assert_select "title", full_title("Edit user")
    get users_path
    assert_select "title", full_title("All users")
  end
end
