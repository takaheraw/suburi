Rails.application.configure do
  config.lograge.enabled        = true
  config.lograge.logger         = ActiveSupport::Logger.new("#{Rails.root}/log/access_#{Rails.env}.log", "daily")
  config.lograge.formatter      = Lograge::Formatters::Json.new
  config.lograge.custom_options = lambda do |event|
    {
      host:          event.payload[:host],
      ip:            event.payload[:ip],
      ua_name:       event.payload[:ua_name],
      ua_category:   event.payload[:ua_category],
      ua_os:         event.payload[:ua_os],
      ua_os_version: event.payload[:ua_os_version],
      ua_version:    event.payload[:ua_version],
      ua_vendor:     event.payload[:ua_vendor],
      referer:       event.payload[:referer],
      user_id:       event.payload[:user_id],
      time:          event.time.iso8601
    }
  end
end
