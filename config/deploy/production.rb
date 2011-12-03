#"set your application name here"
set :application, "forum_demo"
#"set your repository location here"
set :domain, "forum_demo"
set :repository, "git@github.com:tamsuiboy/forum_demo.git"
set :deploy_to, "/home/apps/forum_demo"

#"your web-server here"                          # Your HTTP server, Apache/etc
role :web, domain
#"your app-server here"                          # This may be the same as your `Web` server
role :app, domain
#"your primary db-server here", :primary => true # This is where Rails migrations will run
role :db, domain, :primary => true
#role :db,  "your slave db-server here"

set :deploy_via, :remote_cache
set :deploy_env, "production"
set :rails_env, "production"
set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :branch, "master"
set :scm_verbose, true
set :use_sudo, false
set :user, "apps"
set :group, "apps"
#set :rake, "rake"
#set :migrate_env, "/opt/ruby/bin/rake"
#set :rake, "/opt/ruby/bin/rake"

default_environment["PATH"] = "/opt/ruby/bin:/opt/ruby/lib/ruby/gems/1.8:/usr/local/bin:/usr/bin:/bin:/usr/games"
#default_environment["rake"] = "rake"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

#namespace :deploy do
#  desc "restart"
#  task :restart do
#    run "touch #{current_path}/tmp/restart.txt"
#  end
#end

desc "Creat database.yml and asset packages for production"
after("deploy:update_code") do
  db_config = "#{shared_path}/database.yml.production"
  run "cp #{db_config} #{release_path}/config/database.yml"
end

#namespace :deploy do
#desc <<-DESC
#  Run the migrate rake task. By default, it runs this in most recently \
#  deployed version of the app. However, you can specify a different release \
#  via the migrate_target variable, which must be one of :latest (for the \
#  default behavior), or :current (for the release indicated by the \
#  `current' symlink). Strings will work for those values instead of symbols, \
#  too. You can also specify additional environment variables to pass to rake \
#  via the migrate_env variable. Finally, you can specify the full path to the \
#  rake executable by setting the rake variable. The defaults are:
#
#    set :rake,           "rake"
#    set :rails_env,      "production"
#    set :migrate_env,    ""
#    set :migrate_target, :latest
#DESC
#task :migrate, :roles => :db, :only => { :primary => true } do
#  migrate_env = fetch(:migrate_env, "")
#  migrate_target = fetch(:migrate_target, :latest)
#
# directory = case migrate_target.to_sym
#    when :current then current_path
#    when :latest  then latest_release
#    else raise ArgumentError, "unknown migration target #{migrate_target.inspect}"
#    end

#  run "cd #{directory} && rake RAILS_ENV=#{rails_env} #{migrate_env} db:migrate"
#end
#end
#desc "Overriding the default deploy:cold"
#namespace :deploy do
#  task :cold do
#    update
#    load_schema
#    start
#  end
#
#  task :load_schema, :roles => :app do
#    run "cd #{current_path}; rake db:schema:load"
#  end
#end

#desc "Search Remote Application Server Libraries"
#task :search_libs, :roles => :app do
#    run "ls -x1 /usr/lib | grep -i xml"
#end
