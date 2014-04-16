require 'spec_helper'

describe 'User sign in' do
  
  let(:user) { FactoryGirl.create(:user) }
  
  describe 'successfull sign in' do
    before { sign_in_with user.email, user.password }
    it { should have_title(user.name) }
  end
end

def sign_in_with(email, password)
  visit sign_in_path
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Sign In'
end