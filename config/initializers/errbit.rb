Airbrake.configure do |config|
  config.host        = Settings.errbit.host
  config.project_id  = 1 # required, but any positive integer works
  config.project_key = Settings.errbit.api_key

  # Uncomment for Rails apps
  config.environment         = Rails.env
  config.ignore_environments = %w(development test)
end
