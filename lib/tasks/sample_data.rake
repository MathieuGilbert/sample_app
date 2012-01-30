require 'faker'

namespace :db do
  desc "Fill database with sample data"
  # define task db:populate, giving it access to local environment
  task :populate => :environment do
    # reset dev database (and test???)
    Rake::Task['db:reset'].invoke
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
end
