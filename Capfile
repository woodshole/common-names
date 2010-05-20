load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy'
namespace :passenger do
  desc "Start Application"
  task :start, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end
end

namespace :deploy do
    task :start do
      passenger.start rescue nil # This catches the error if we don't have an app server defined
    end

    task :restart do
      passenger.restart rescue nil # This catches the error if we don't have an app server defined
    end

  task :stop do
    passenger.stop rescue nil # This catches the error if we don't have an app server defined
  end
end