namespace :user_admin do
  desc "make a user an administrator"
  task :make_admin => :environment do
    begin
      u = User.find_by_email(ENV["user"]) 
    rescue
      puts "That user does not exist"
      return
    end
    u.options['admin'] = true
    u.save
    puts "Great, #{ENV["user"]} is now an admin!"
  end
end