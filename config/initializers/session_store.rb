Rails.application.config.session_store :redis_store, {
  servers: [
    {
      host:      Settings.redis.host,
      port:      Settings.redis.port,
      db:        Settings.redis.db,
      namespace: [Settings.redis.namespace, "session"].join(':')
    },
  ],
  expire_after: 1.week,
  key: "_#{Rails.application.class.parent_name.downcase}_session"
}
