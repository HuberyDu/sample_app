require 'spec_helper'

describe "UserPages" do

  before { @user = User.new(name:"xixiha", 
                            email:"xixiha@qq.com",
                            password:"xixiha",
                            password_confirmation:"xixiha")}
  subject{@user}

  it{should be_valid}

  describe "User" do

  	it{should respond_to(:name)}
  	it{should respond_to(:email)}
  end

  describe "when name is not present" do
  	before { @user.name = ''}
	it{should_not be_valid }  	
  end

  describe "when email is not present" do
  	before { @user.email = ''}
  	it{ should_not be_valid }
  end 

  describe "name is long" do
  	before { @user.name = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"}
  	it{ should_not be_valid}
  end

  describe "when email format is invalid" do 
    it "should be invalid" do
      addresses = %w[user.com, user@, user@Foo,com]
      addresses.each do |address|
        @user.email = address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@qq.com]
      addresses.each do |address|
        @user.email = address
        expect(@user).to be_valid
      end
    end
  end

  describe "signup page" do
    subject{page}
    before{ visit signup_path}
    it{should have_content("Sign")}
  end

  describe "profile page" do
    subject{page}
    let(:user){FactoryGirl.create(:user)}
    before{visit user_path(user)}
    it{should have_content(user.name)}
  end

  describe "Sign Up" do
    subject{page}
    before{visit signup_path}
    let(:submit){"Create my account"}

    describe "with invalid information" do
      it "should not create user" do
        expect{click_button submit}.not_to change(User,:count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with:"User"
        fill_in "Email",        with:"User@gmail.com"
        fill_in "Password",     with:"user"
        fill_in "Confirmation", with:"user"
      end

      it "should create user" do
        expect{click_button submit}.to change(User,:count)
      end
    end
  end
end
