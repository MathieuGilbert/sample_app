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
    
    describe "for logged-in users" do
      before(:each) do
        @user = test_sign_in(Factory(:user))
        other_user = Factory(:user, :email => Factory.next(:email))
        other_user.follow!(@user)
      end
      
      describe "with many microposts" do
        before(:each) do
          50.times do
            Factory(:micropost, :user => @user,
                                :content => "test")
          end
        end
        
        it "should paginage" do
          get :home
          response.should have_selector('div.pagination')
          response.should have_selector('span.disabled', :content => "Previous")
          response.should have_selector('a', :href => '/?page=2')
          response.should have_selector('a', :href => "/?page=2",
                                             :content => "Next")    
        end
      end
      
      it "should have the right follower/following counts" do
        get :home
        response.should have_selector('a', :href => following_user_path(@user),
                                           :content => "0 following")
        response.should have_selector('a', :href => followers_user_path(@user),
                                           :content => "1 follower")
      end
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
