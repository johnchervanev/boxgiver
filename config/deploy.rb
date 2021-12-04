# config valid for current version and patch releases of Capistrano

# lock "3.14.1"



# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads', 'tmp/reports'
append :linked_files, 'config/database.yml', 'config/secrets.yml', 'config/application.yml', 'config/config.yml'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 3
set :rvm_ruby_version, '2.6.5'

set :npm_flags, '--production'

set :nvm_type, :user
set :nvm_map_bins, %w{node npm yarn}

set :node_env, (fetch(:node_env) || fetch(:stage))

# Default value for default_env is {}
set :default_env, { node_env: fetch(:node_env) }


# Default value for default_env is {}
set :default_env, { node_env: fetch(:node_env) }

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

# set :whenever_command, 'bundle exec whenever --update-crontab'

namespace :deploy do

  desc "Installing npm..."
  task :install_npm do
    on roles(:app) do
      execute "cd '#{release_path}' && source ~/.nvm/nvm.sh && rm -fr node_modules && npm install"
    end
  end

  desc "Building angular app..."
  task :build_app do
    on roles(:app) do
      execute "cd '#{release_path}/client' && source ~/.nvm/nvm.sh && npm run build:client"
    end
  end

  # before :publishing, 'deploy:install_npm'
  # before :publishing, 'deploy:build_app'
  after :publishing, 'deploy:restart'

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end
