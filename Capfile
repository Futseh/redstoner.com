# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'
require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/puma'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'

namespace :deploy do
  desc 'Start application'
  task(:start) {}

  desc 'Stop application'
  task(:stop) {}
end

# Load custom tasks from `lib/capistrano/tasks' if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
