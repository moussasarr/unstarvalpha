desc "This task is called by the Heroku scheduler add-on"

task remove_excessive_groupchatcomments: :environment do
  puts "Removing excessive comments now..."
  Groupchatcomment.remove_excessive!
end


task remove_excessive_chatcomments: :environment do
  puts "Removing excessive comments now..."
  Chatcomment.remove_excessive!
end