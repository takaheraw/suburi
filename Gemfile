source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'jbuilder', '~> 2.5'
gem 'mysql2', '>= 0.5.2'
gem 'puma', '~> 3.11'
gem 'rails', '~> 6.0.0.rc1'
gem 'sidekiq'
gem 'sidekiq-bulk'
gem 'sidekiq-failures'
gem 'sidekiq-history'
gem 'sidekiq-scheduler'
gem 'sidekiq-unique-jobs'
gem 'webpacker', '~> 4.0'

group :development, :test do
  gem 'factory_bot_rails'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'brakeman', require: false
  gem 'bullet'
  gem 'bundler-audit', require: false
  gem 'derailed_benchmarks'
  gem 'foreman'
  gem 'hirb'
  gem 'i18n_generators'
  gem 'letter_opener'
  gem 'listen'
  gem 'memory_profiler'
  gem 'rails-erd'
  gem 'rubocop'
end

group :test do
  gem 'database_cleaner'
  gem 'faker'
  gem 'json_schema'
  gem 'oas_parser'
  gem 'rails-controller-testing'
  gem 'rspec-sidekiq'
  gem 'shoulda-matchers'
  gem 'webmock'
end
