set :application, "raffledrum"
set :repository,  "git://github.com/eugenebolshakov/raffledrum.git"
set :rails_env, 'production'
set :use_sudo, false

default_run_options[:pty] = true

set :scm, "git"
set :scm_passphrase, ""
set :user, 'eugenebolshakov'

set :deploy_to, "/home/eugenebolshakov/raffledrum.taknado.com"

role :app, "taknado.com"
role :web, "taknado.com"
role :db,  "taknado.com", :primary => true


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
