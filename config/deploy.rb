set :application, "raffledrum"
set :repository,  "git@github.com:railsrumble/rr09-team-41.git"

default_run_options[:pty] = true

set :scm, "git"
set :scm_passphrase, ""
set :user, "rumble09-041"

set :deploy_to, "/var/www/#{application}"

role :app, "97.107.134.144"
role :web, "97.107.134.144"
role :db,  "97.107.134.144", :primary => true


desc "Symlink the database config file from shared directory to current release directory."
task :symlink_database_yml do
  run "ln -nsf #{shared_path}/config/database.yml
       #{release_path}/config/database.yml"
end

desc "Installs and builds gems as specified in environment.rb"
task :rake_install_and_build_gems, :roles=>:app_admin do 
  run "cd #{release_path}; sudo rake gems:install RAILS_ENV=#{fetch :rails_env}" 
  # run "cd #{release_path}; sudo rake gems:build RAILS_ENV=#{fetch :rails_env}"
end

namespace(:deploy) do
  desc "Restart rails phusion passenger"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt -m"
  end
end

after 'deploy:update_code' , 'symlink_database_yml'
after 'deploy' , 'rake_install_and_build_gems'
