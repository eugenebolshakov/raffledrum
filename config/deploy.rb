set :application, "raffledrum"
set :repository,  "git@github.com:railsrumble/rr09-team-41.git"
set :rails_env, 'production'

default_run_options[:pty] = true

set :scm, "git"
set :scm_passphrase, ""
set :branch, "railsrumble09"
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

namespace(:deploy) do
  desc "Restart rails phusion passenger"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt -m"
  end
end

after 'deploy:update_code' , 'symlink_database_yml'

# DJ tasks
after "deploy:stop", "delayed_job:stop"
after "deploy:start", "delayed_job:start"
after "deploy:restart", "delayed_job:restart"
