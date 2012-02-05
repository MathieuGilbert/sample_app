require 'spec_helper'

describe PagesController do
  render_views
  
  before(:each) do
    @base_title = base_title
  end

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'home'
      response.should have_selector("title", 
                                    :content => @base_title + " | Home")
    end
  end

  describe "GET 'contact'" do
    it "returns http success" do
      get 'contact'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'contact'
      response.should have_selector("title", 
                                    :content => @base_title + " | Contact")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'about'
      response.should have_selector("title", 
                                    :content => @base_title + " | About")
    end
  end
  
  describe "GET 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'help'
      response.should have_selector("title", 
                                    :content => @base_title + " | Help")
    end
  end
  
  describe "sidebar" do
    before(:each) do
      @user = test_sign_in(Factory(:user, :email => Factory.next(:email)))
    end
    
    it "should show microposts" do
      get :home
      response.should have_selector('span', :class => 'microposts')
    end
    
    it "should say '1 micropost'" do
      mp1 = Factory(:micropost, :user => @user)
      get :home
      response.should have_selector('span', :class => 'microposts',
                                            :content => "1 micropost")
    end
    
    it "should say '2 microposts'" do
      mp1 = Factory(:micropost, :user => @user)        
      mp2 = Factory(:micropost, :user => @user)
      get :home
      response.should have_selector('span', :class => 'microposts',
                                            :content => "2 microposts")
    end
  end
end
