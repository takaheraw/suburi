source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'active_decorator'
gem 'active_model_serializers'
gem 'airbrake', '~> 10.0'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'config'
gem 'devise'
gem 'doorkeeper', '~> 5.3.2'
gem 'hiredis'
gem 'jbuilder', '~> 2.5'
gem 'lograge'
gem 'mysql2', '>= 0.5.2'
gem 'oauth2'
gem 'puma', '~> 4.1'
gem 'pundit'
gem 'rails', '~> 6.0.2.2'
gem 'redis'
gem 'redis-namespace'
gem 'redis-rails'
gem 'sidekiq'
gem 'sidekiq-bulk'
gem 'sidekiq-failures'
gem 'sidekiq-history'
gem 'sidekiq-scheduler'
gem 'sidekiq-unique-jobs'
gem 'webpacker', '~> 5.1'
gem 'woothee'

group :development, :test do
  gem 'brakeman', require: false
  gem 'factory_bot_rails'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'bullet'
  gem 'bundler-audit', require: false
  gem 'derailed_benchmarks'
  gem 'foreman'
  gem 'hirb'
  gem 'i18n_generators'
  gem 'listen', '>= 3.0.5', '< 3.3'
  gem 'letter_opener'
  gem 'memory_profiler'
  gem 'rails-erd'
  gem 'rubocop'
end

group :test do
  gem 'committee'
  gem 'committee-rails'
  gem 'database_cleaner'
  gem 'faker'
  gem 'rails-controller-testing'
  gem 'rspec-sidekiq'
  gem 'rspec_junit_formatter'
  gem 'simplecov', require: false
  gem 'shoulda-matchers'
  gem 'webmock'
end
