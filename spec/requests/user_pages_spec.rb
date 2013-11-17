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
        fill_in "Email",        with:"duxiaolong92@gmail.com"
        fill_in "Password",     with:"user"
        fill_in "Confirmation", with:"user"
      end
      it "should create user" do
        expect{click_button submit}.to change(User,:count)
      end
    end
    describe "Authentication" do

      subject { page }

      describe "signin page" do
        before { visit signin_path }

        it { should have_content('Sign in') }
        it { should have_title('Sign in') }
      end
    end
  
    describe "signin" do
      subject{page}
      before{
        visit signin_path
        click_button "Sign in"}
        
      describe "with invalid information" do
        it { should have_selector('div.alert.alert-error', text: 'Invalid') }
      end

      describe "with valid information" do
        let(:user){FactoryGirl.create(:user)}
        before{
          fill_in "Email", with: user.email.upcase
          fill_in "Password", with: user.password
          click_button "Sign in"
        }
      end


    end 

    describe "remember_token" do
      before{@user.save}

      it{expect(@user.remember_token).not_to be_blank}
    end
  end

  describe "index" do
    subject{page}

    describe "index" do
      before do
        sign_in FactoryGirl.create(:user)
        FactoryGirl.create(:user, name: "bob", email: "bob@example.com")
        FactoryGirl.create(:user, name: "ben", email: "ben@example.com")
        visit users_path
      end

      it { should have_title('All users') }
      it { should have_content('All users') }

      it "should list each user" do
        User.all.each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end
  end
end
