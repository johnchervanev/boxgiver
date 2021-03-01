# set path to application
app_dir = File.expand_path("../..", __FILE__)
shared_dir = "#{app_dir}/shared"
working_directory app_dir


# Set unicorn options
# worker_processes should be set equal to the number of cores your machine has, visible with 'lscpu'
worker_processes 3 
preload_app true
timeout 30

# Set up socket location
#listen 3000 # listen to port 3000 on all TCP interfaces
#listen "127.0.0.1:3000"  # listen to port 3000 on the loopback interface
#listen "[::1]:3000" # listen to port 3000 on the IPv6 loopback interface
listen "#{shared_dir}/sockets/unicorn.sock", :backlog => 64

# Logging
stderr_path "#{shared_dir}/log/unicorn.stderr.log"
stdout_path "#{shared_dir}/log/unicorn.stdout.log"

# Set master PID location
pid "#{shared_dir}/pids/unicorn.pid"
