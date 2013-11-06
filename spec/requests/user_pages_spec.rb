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
end
