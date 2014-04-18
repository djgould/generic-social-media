require 'spec_helper'

describe 'User Pages' do
  
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user, name: 'Nick McCooey', email: 'nickmccooey@yahoo.com') }
  subject { page }
  
  describe 'Signed In' do
    before { sign_in_with user.email, user.password }
    
    describe 'show page' do
      before { visit user_path(user) }
      
      it { should have_title(user.name) }
    end
  end
end