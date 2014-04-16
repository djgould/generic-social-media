require 'spec_helper'

describe Friendship do
  before(:each) do
    @user = User.new(name: 'Devin Gould', email: 'djgould0628@gmail.com', 
      password: 'password', password_confirmation: 'password')
    @friend = User.new(name: 'Nick McCooey', email: 'nickmccooey@gmail.com', 
      password: 'password', password_confirmation: 'password')
    @user.save
    @friend.save
  end
  
  describe 'class methods' do
    it 'should create request' do
      Friendship.request(@user, @friend)
      status(@user, @friend).should == Friendship::PENDING
      status(@friend, @user).should == Friendship::REQUESTED
    end
    
    it 'should accept a request' do
      Friendship.request(@user, @friend)
      Friendship.accept(@friend, @user)
      status(@user, @friend).should == Friendship::ACCEPTED
      status(@friend, @user).should == Friendship::ACCEPTED
    end
    
    it 'should unfriend' do
      Friendship.request(@user, @friend)
      Friendship.unfriend(@user, @friend)
      Friendship.exists?(@user, @friend).should == false
      Friendship.exists?(@friend, @user).should == false
    end
  end
  
  def status(user, friend)
    Friendship.conn(user, friend).status
  end
end
