require 'spec_helper'

describe "AuthenticationPages" do
  subject{page}

  describe "signin page" do
    before{visit signin_path}
    it{should have_content("Sign in")}
  end

  describe "with valid information" do
  	let(:user){FactoryGirl.create(:user)}
  	before{signin user}

  	 it { should have_title(user.name) }
     it { should have_link('Profile',     href: user_path(user)) }
     it { should have_link('Settings',    href: edit_user_path(user)) }
     it { should have_link('Sign out',    href: signout_path) }
     it { should_not have_link('Sign in', href: signin_path) }
  end

  

end
