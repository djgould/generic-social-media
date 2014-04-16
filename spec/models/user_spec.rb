require 'spec_helper'

describe User do
  before { @user = User.new(name: 'Devin Gould', email: 'djgould0628@gmail.com', 
    password: 'foobar', password_confirmation: 'foobar') }
  
  subject { @user }
  
  it { should respond_to :name }
  it { should respond_to :email }
  it { should respond_to :password_digest }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  
  it { should be_valid }
  
  describe 'name should not be blank' do
    before { @user.name = '' }
    it { should_not be_valid }
  end
  
  describe 'email should not be blank' do
    before { @user.email = '' }
    it { should_not be_valid }
  end
  
  describe 'email should be unique' do
    before do
      @user.save
      @new_user = User.new(name: 'Devin', email: @user.email,
        password: 'password', password_confirmation: 'password')
    end
    it 'should not be valid' do
      expect(@new_user).not_to be_valid
    end
  end
  
  describe 'password should not be blank' do
    before { @user.password = @user.password_confirmation = '' }
    it { should_not be_valid }
  end
  
  describe 'passwords should match' do
    before { @user.password = 'mismatch' }
    it { should_not be_valid }
  end
  
  describe 'friendships' do
    before do
      @other_user = User.new(name: 'Nick McCooey', email: 'nickmccooey@yahoo.com',
        password: 'airplane1', password_confirmation: 'airplane1')
      @other_user.save!
      @user.save!
      Friendship.request(@user, @other_user)
    end
    
    it 'should not include pending friend as friend' do
      @friends = @user.friends
      expect(@friends.first).to eq nil
    end
    
    it 'should include user as requestd_friend for other user' do
      @requested_friend = @other_user.requested_friend
      expect(@requested_friend.first).to eq @user
    end
    
    it 'should include friend after accepted request' do
      Friendship.accept(@other_user, @user)
      @friends = @user.friends
      expect(@friends.first).to eq @other_user
    end
  end
end
