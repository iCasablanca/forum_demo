set :application, "forum_demo"
set :domain, "forum_demo"
set :repository, "git@github.com:tamsuiboy/forum_demo.git"
set :deploy_to, "/home/apps/forum_demo"

role :app, domain
role :web, domain
role :db, domain, :primary => true

set :deploy_via, :remote_cache
set :deploy_env, "production"
set :rails_env, "production"
set :scm, :git
set :branch, "master"
set :scm_verbose, true
set :use_sudo, false
set :user, "apps"
set :group, "apps"

default_environment["PATH"] = "/opt/ruby/bin:/usr/local/bin:/usr/bin:/bin:/usr/games"

namespace :deploy do
  desc "restart"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

namespace :rake do
  task :show_tasks do
    run("cd #{deploy_to}/current; /usr/bin/rake -T")
  end
end

desc "Creat database.yml and asset packages for production"
after("deploy:update_code") do
  db_config = "#{shared_path}/database.yml.production"
  run "cp #{db_config} #{release_path}/config/database.yml"
end
