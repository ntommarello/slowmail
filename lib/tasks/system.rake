namespace :system do
  desc "Sends any letters scheduled for delivery"
  task :deliver_letters => :environment do
      Letter.not_delivered.time_for_delivery.each do |letter|
      	letter.deliver_letter 
      	puts "sent: #{letter.id}"
      end
  end

  desc "Fixes sidebar if db is messed up"
  task :rebuild_sidebar => :environment do

  	User.all.each do |user|
  		
  		@letters = Letter.letters_received_or_sent_for(user.id)

  		for letter in @letters


  		end

  	end

  end

  desc "Cleans db"
  task :clean_db => :environment do
  end

end