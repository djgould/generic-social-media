require 'spec_helper'

describe 'User sign in' do
  
  let(:user) { FactoryGirl.create(:user) }
  
  subject { page }
  
  describe 'successfull sign in' do
    before { sign_in_with user.email, user.password }
    it { should have_title(user.name) }
    
    describe 'user should be able to visit index page' do
      before { visit users_path }
      it { should have_title('All Users') }
    end
  end
  
  describe 'unsuccessfull sign in' do
    before { sign_in_with 'invalid@email.com', 'password' }
    it { should have_title('Sign In') }
    
    describe 'should not be able to visit index page' do
      before { visit users_path }
      it { should have_title('Sign In') }
    end
    
    describe 'should not be able to visit user page' do
      before { visit user_path(user) }
      it { should have_title('Sign In') }
    end
  end
end

def sign_in_with(email, password)
  visit sign_in_path
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Sign In'
end