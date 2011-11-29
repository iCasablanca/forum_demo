namespace :dev  do
  desc "Populator database"
  task :fake => :environment do
    Dir[File.dirname(__FILE__) + '/../../app/models/*.rb'].each do | file|
      require file
    end

    #require 'populator'
    #require 'faker'
    #[Board].each(&:delete_all)
    
    admin = User.first
    Board.populate(10) do |board|
      board.name = Populator.words(1).titleize 
      Post.populate(10) do |post|
        post.title = Populator.words(1).titleize
        post.content = Faker::Name.name + "    " + Faker::Company.name + "    " + Faker::Internet.email + "    " + Faker::PhoneNumber.phone_number + "    " + Faker::Address.street_address + "    " + Faker::Address.city + "    " + Faker::Address.us_state_abbr + "    " + Faker::Address.zip_code + "    " + Faker::Lorem.sentence(3) + "    " + Faker::Lorem.paragraph(5)
        post.user_id = admin.id
        post.board_id = board.id
      end
    end 

    
  end
end
