require 'spec_helper'

describe Post do
  let(:user) { FactoryGirl.create(:user) }
  
  before { @post = user.posts.build(content: 'My first post') }
  
  subject { @post }
  
  it { should respond_to :user }
  it { should respond_to :content }
  
  it { should be_valid }
  
  describe 'content should not be blank' do
    before { @post.content = '' }
    it { should_not be_valid }
  end
  
  describe 'user id should not be blank' do
    before { @post.user_id = '' }
    it { should_not be_valid }
  end
  
  describe 'content should not be too long' do
    before { @post.content = 'A' * 250 }
    it { should_not be_valid }
  end
end