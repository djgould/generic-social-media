require 'spec_helper'

describe 'Friend Requests' do
  
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user, name: 'Nick McCooey', email: 'nickmccooey@yahoo.com') }
  
  subject { page }
  
  describe 'add other user' do
    before do 
      sign_in_with user.email, user.password
      visit user_path(other_user)
    end
    
    it { should have_title(other_user.name) }
    
    it "should be able to send friend request" do
      expect do
        click_link 'Add Friend'
      end.to change{other_user.requested_friends.count}.by(1)
      expect(page).not_to have_link 'Add Friend'
      expect(page).to have_text("You have sent #{other_user.name} a friend request")
    end
    
    describe "responding to request" do
      before do
        Friendship.request(user, other_user)
        sign_in_with other_user.email, other_user.password
      end
      it "should be able to respond to request" do
        expect(page).to have_title(other_user.name)
        expect do
          click_link 'Respond?'
          click_button 'Accept'
        end.to change{other_user.friends.count}.by(1)
        expect(page).to have_content("#{user.name} is your friend")
      end
    end
  end
end

def sign_in_with(email, password)
  visit sign_in_path
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Sign In'
end