require 'capistrano/ext/multistage'
require 'bundler/capistrano' #Using bundler with Capistrano

set :stages, %w(staging production)
set :default_stage, "production"
namespace :rake do  
  desc "Run a task on a remote server."  
  # run like: cap staging rake:invoke task=a_certain_task  
  task :invoke do  
    run("cd #{deploy_to}/current; /usr/bin/env rake #{ENV['task']} RAILS_ENV=#{rails_env}")  
  end  
end
