# config valid only for current version of Capistrano
lock '3.4.0'

set :repo_url, 'git@bitbucket.org:redstonesheep/redstoner.git'

set :scm, :git

set :ssh_options, { forward_agent: true }

set :keep_releases, 5

set :deploy_to, -> { "/home/www-data/apps/#{fetch(:application)}" }

set :rbenv_ruby, '2.0.0-p247'

set :bundle_without, %w{development test}.join(' ')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

namespace :deploy do
  after :publishing, :restart
end