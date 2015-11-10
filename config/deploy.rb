require 'sidekiq/capistrano'

set :sidekiq_cmd, "#{bundle_cmd} exec sidekiq"
set :sidekiqctl_cmd, "#{bundle_cmd} exec sidekiqctl"
set :sidekiq_timeout, 90
set :sidekiq_role, :app
set :sidekiq_pid, "#{current_path}/tmp/pids/sidekiq.pid"
set :sidekiq_processes, 1