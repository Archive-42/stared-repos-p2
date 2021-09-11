require "spec_helper"
require "cancan/matchers"

describe Ability do
  subject { ability }
  let(:ability) { Ability.new(user) }
  
  context 'Unauthorized user' do
    let(:user) { nil }
    
    it { should be_able_to(:show, :sitemap) }
    it { should be_able_to(:show, :users) }
    it { should be_able_to(:show, :posts) }
    it { should be_able_to(:index, :posts) }
    it { should be_able_to(:show, :tags) }
    it { should be_able_to(:show, :gists) }
    it { should be_able_to(:show, :searches) }
    it { should be_able_to(:create, :searches) }
    it { should be_able_to(:create, :users) }
  end
  
  context 'Authorized user' do
    let(:user) { FactoryGirl.create(:user) }
    
    it { should be_able_to(:new, :posts) }
    it { should be_able_to(:create, :posts) }
    it { should be_able_to(:destroy, :sessions) }
    it { should be_able_to(:create, :comments) }
    it { should be_able_to(:index, :'account/subscriptions') }
    it { should be_able_to(:create, :'account/subscriptions') }
    it { should be_able_to(:index, :'account/gists') }
    it { should be_able_to(:index, :'account/notifications') }
    
    describe 'working with subscriptions' do
      context 'alian subscription' do
        let(:subscription) { FactoryGirl.create(:subscription) }
        it { should_not be_able_to(:destroy, subscription) }
      end
      
      context 'self subscriptions' do
        let(:subscription) { FactoryGirl.create(:subscription, :user => user)}
        it do
          # should be_able_to(:destroy, :subscription)
          pending "I don't know how to test cancan with controller in the namespaces"
        end
      end
    end
    
    describe 'working with posts' do
      context 'alian post' do
        let(:post) { FactoryGirl.create(:post) }
        it { should_not be_able_to(:edit, post) }
        it { should_not be_able_to(:update, post) }
        it { should_not be_able_to(:destroy, post) }
      end
      
      context 'self post' do
        let(:post) { FactoryGirl.create(:post, :user => user) }
        it { should be_able_to(:edit, post) }
        it { should be_able_to(:update, post) }
        it { should be_able_to(:destroy, post) }
      end
    end
  end
  
  context 'Admin user' do
    let(:user) { FactoryGirl.create(:admin) }
    
    it { should be_able_to(:access, :all) }
  end
  
  describe 'Simple Authorization' do
    let(:user) { nil }
    
    context 'development env' do
      before { subject.stub(:development?, true) }
      it { should be_able_to(:create, :sessions) }
    end
    
    context 'production env' do
      before { subject.stub(:development?, false) }
      it do
        # should_not be_able_to(:create, :sessions)
        pending "to understand why test not working"
      end
    end
  end
end
