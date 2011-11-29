# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

admin = User.new(:email => "admin@azion.tw", :password => "password", :password_confirmation => "password")
admin.is_admin = true
admin.save!

normal_user = User.new(:email => "user@azion.tw", :password => "password", :password_confirmation => "password")
normal_user.save!

board = Board.create!(:name => "System Announcement")

post = board.posts.build(:title => "First Post", :content => "This is a demo post")
post.user_id = admin.id
post.save!
