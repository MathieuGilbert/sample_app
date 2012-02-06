namespace :db do
  desc "Fill database with sample data"
  # define task db:populate, giving it access to local environment
  task :populate => :environment do
    require 'faker'
    
    # reset dev database (and test???)
    Rake::Task['db:reset'].invoke
    make_users
    make_microposts
    make_relationships
  end
end

def make_users
  # create one sample user
  admin = User.create!(:name => "Example User",
                       :email => "example@railstutorial.org",
                       :password => "foobar",
                       :password_confirmation => "foobar")
  admin.toggle!(:admin)
  # create 99 more sample users
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(:name => name,
                 :email => email,
                 :password => password,
                 :password_confirmation => password)
  end
end

def make_microposts
  User.all(:limit => 6).each do |user|
    50.times do
      user.microposts.create!(:content => Faker::Lorem.sentence(5))
    end
  end
end

def make_relationships
  users = User.all
  user = users.first
  following = users[1..50]
  followers = users[3..40]
  
  following.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end
