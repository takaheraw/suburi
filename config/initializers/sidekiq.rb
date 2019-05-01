redis_params = {
  url: "redis://#{Settings.redis.host}:#{Settings.redis.port}",
  namespace: [Settings.redis.namespace, 'sidekiq'].join(':')
}

Sidekiq.configure_server do |config|
  config.redis = redis_params
end

Sidekiq.configure_client do |config|
  config.redis = redis_params
end

Sidekiq::Logging.logger.level = ::Logger.const_get('info'.upcase.to_s)
