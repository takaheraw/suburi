redis_connection = Redis.new(
  host: Settings.redis.host,
  port: Settings.redis.port,
  db: Settings.redis.db,
  driver: :hiredis
)

Redis.current = Redis::Namespace.new(Settings.redis.namespace, redis: redis_connection)
