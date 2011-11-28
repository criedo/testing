# spec/requests/users_spec.rb crfr110911
require 'spec_helper'

describe "Users" do
  describe "signup" do
    describe "failure" do
      it "should not make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => ""
          fill_in "Email",        :with => ""
          fill_in "Password",     :with => ""
          fill_in "Confirmation", :with => ""
          click_button
          response.should render_template('users/new')
          response.should have_selector("div#error_explain")
        end.should_not change(User, :count)
      end
    end
    describe "success" do
      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => "Example User"
          fill_in "Email",        :with => "user@example.com"
          fill_in "Password",     :with => "foobar"
          fill_in "Confirmation", :with => "foobar"
          click_button
          response.should have_selector("div.flash.success", :content => "Welcome")
          response.should render_template('users/show')
        end.should change(User, :count).by(1)
      end
    end
  end
  describe "sign in/out" do
    describe "failure" do
      it "should not sign a user in" do
        visit signin_path
        fill_in :email,    :with => ""
        fill_in :password, :with => ""
        click_button
        response.should have_selector("div.flash.error", :content => "Invalid")
      end
    end
    describe "success" do
      it "should sign a user in and out" do
        user = Factory(:user)
        integration_sign_in(user)
        controller.should be_signed_in
        click_link "Sign out"
        controller.should_not be_signed_in
      end
    end
  end
  describe "micropost associations" do
    before(:each) do
      @user = Factory(:user)
      @mp1 = Factory(:micropost, :user => @user, :created_at => 1.day.ago)
      @mp2 = Factory(:micropost, :user => @user, :created_at => 1.hour.ago)
    end
    it "should have a microposts attribute" do
      @user.should respond_to(:microposts)
    end
    it "should have the right microposts in the right order" do
      @user.microposts.should == [@mp2, @mp1]
    end
    it "should destroy associated microposts" do
      @user.destroy
      [@mp1, @mp2].each do |micropost|
        Micropost.find_by_id(micropost.id).should be_nil
      end
    end
    it "should have the 1 micropost' message" do
      @mp2.destroy
      visit user_path(@user)
      response.should have_selector("div.sidebar strong", :content => "1 micropost")
    end
    it "should have the 2 microposts' message" do
      visit user_path(@user)
      response.should have_selector("div.sidebar strong", :content => "2 microposts")
    end
    it "should have pagination" do
      @user.microposts.paginate(:page => 1, :per_page => 1)
      visit user_path(@user)
      response.should have_selector("div.microposts_pages")
    end
    it "should have the delete image" do
      integration_sign_in(@user)
      visit microposts_path
      response.should have_selector("div.img_delete")
    end
    it "shouldn't have the delete image" do
      wrong_user = Factory(:user, :email => Factory.next(:email))
      integration_sign_in(wrong_user)
      visit microposts_path
      response.should_not have_selector("div#img_delete")
    end
    it "should have the following stat" do
      integration_sign_in(@user)
      visit user_path(@user)
      response.should have_selector("div.stats")
    end
  end
  describe "relationships" do
    before(:each) do
      @attr = { :name => "Example User", :email => "user@example.com", :password => "foobar", :password_confirmation => "foobar" }
      @user = User.create!(@attr)
      @followed = Factory(:user)
    end
    it "should follow the user" do
      integration_sign_in(@user)
      visit user_path(@followed)
      lambda do
        click_button
      end.should change(@user.following, :count).by(1)
    end
    it "should unfollow the user" do
      @user.follow!(@followed)
      integration_sign_in(@user)
      visit user_path(@followed)
      lambda do
        click_button
      end.should change(@user.following, :count).by(-1)
    end
  end
end