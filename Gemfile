source 'https://rubygems.org'

# Specify your gem's dependencies in bitbucket.gemspec
gemspec

group :development, :test do
  gem 'pry'
  gem 'pry-stack_explorer'
  gem 'pry-byebug'
  gem 'pry-rescue'

  gem 'guard-rspec'
  gem 'guard-spork'

  gem 'guard-rubocop'
  gem 'gem-release'
end

group :test do
  gem 'coveralls', require: false
  gem 'codeclimate-test-reporter', require: nil
end
