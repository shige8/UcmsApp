# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#
max_threads_count = ENV.fetch('RAILS_MAX_THREADS') { 5 }
min_threads_count = ENV.fetch('RAILS_MIN_THREADS') { max_threads_count }
threads min_threads_count, max_threads_count

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
#
# port        ENV.fetch('PORT') { 3000 }

# socketの設定
# bind "unix://#{Rails.root}/tmp/sockets/puma.sock"
app_root = File.expand_path("../../..", __FILE__)
# bind "unix://#{app_root}/tmp/sockets/puma.sock"
# stdout_redirect "#{app_root}/log/puma.stdout.log", "#{app_root}/log/puma.stderr.log", true

worker_processes 1
# currentを指定
working_directory "#{app_path}/current"

# それぞれ、sharedの中を参照するよう変更(#{app_path}/shared/)
listen "#{app_path}/shared/tmp/sockets/puma.sock"
pid "#{app_path}/shared/tmp/pids/puma.pid"
stderr_path "#{app_path}/shared/log/puma.stderr.log"
stdout_path "#{app_path}/shared/log/puma.stdout.log"
# Specifies the `environment` that Puma will run in.
#
environment ENV.fetch('RAILS_ENV') { ENV['RACK_ENV'] || 'production' }

# Specifies the `pidfile` that Puma will use.
pidfile ENV.fetch('PIDFILE') { 'tmp/pids/server.pid' }

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked web server processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
#
workers ENV.fetch('WEB_CONCURRENCY') { 2 }

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory.
#
preload_app!

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart
