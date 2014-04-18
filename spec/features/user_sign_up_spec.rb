require 'spec_helper'

describe 'User Sign Up' do
  
  let(:user) { FactoryGirl.build(:user) }
  
  subject { page }
  
  describe 'sign up with valid info' do
    before { sign_up_with user.name, user.email, user.password, user.password }
    it { should have_title(user.name) }
    
    describe 'duplicate email' do
      before { sign_up_with user.name, user.email, user.password, user.password }
      it { should have_title('Sign Up') }
    end
    
  end
  
  describe 'sign up with invalid info' do
    
    describe 'blank name' do
      before { sign_up_with '', user.email, user.password, user.password }
      it { should have_title('Sign Up') }
    end
    
    describe 'blank email' do
      before { sign_up_with user.name, '', user.password, user.password }
      it { should have_title('Sign Up') }
    end
    
    describe 'mismatch password' do
      before { sign_up_with user.name, user.email, user.password, 'mismatch' }
      it { should have_title('Sign Up') }
    end
    
    describe 'blank password' do
      before { sign_up_with user.name, user.email, '', '' }
      it { should have_title('Sign Up') }
    end
  end
end

def sign_up_with(name, email, password, password_confirmation)
  visit sign_up_path
  fill_in 'Name', with: name
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  fill_in 'Password confirmation', with: password_confirmation
  click_button 'Sign Up'
end