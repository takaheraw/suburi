module Request
  class BadRequest < StandardError; end   # 400
  class NotFound < StandardError; end     # 404
  class ServerError < StandardError; end  # 500 系と接続エラー
  class TimeOutError < StandardError; end # タイムアウト

  class Client
    DEFAULT_ACCEPT = "application/json"

    DEFAULT_HOST = "#{Settings.client.host}"

    DEFAULT_USER_AGENT = "Omsubi Ruby Gem #{Request::VERSION}"

    DEFAULT_HEADERS = {
      "Accept"     => DEFAULT_ACCEPT,
      "User-Agent" => DEFAULT_USER_AGENT
    }

    include ResourceBasedMethods

    def initialize(access_token: nil, host: nil, ssl: true)
      @access_token = access_token
      @host = host
      @ssl = ssl
    end

    def get(path, params = nil, headers = nil)
      process(:get, path, params, headers)
    end

    def post(path, params = nil, headers = nil)
      process(:post, path, params, headers)
    end

    def post_multipart(path, params = nil, headers = nil)
      process(:post, path, params, headers)
    end

    def patch(path, params = nil, headers = nil)
      process(:patch, path, params, headers)
    end

    def put(path, params = nil, headers = nil)
      process(:put, path, params, headers)
    end

    def delete(path, params = nil, headers = nil)
      process(:delete, path, params, headers)
    end

    def connection
      @connection ||= Faraday.new(faraday_client_options) do |connection|
        connection.request :retry,
        max: Settings.client.retry_max,
        interval: Settings.client.retry_interval,
        exceptions: [Faraday::Error::TimeoutError, Faraday::Error::ConnectionFailed, Faraday::Error::ClientError],
        retry_if: ->(env, _exception) { !(400..499).include?(env.status) }
        connection.request  :url_encoded
        connection.response :logger
        connection.response :json
        connection.response :raise_error
        connection.adapter Faraday.default_adapter
      end
    end

    private

    def base_host
      @host || DEFAULT_HOST
    end

    def default_headers
      headers = DEFAULT_HEADERS.clone
      headers["Authorization"] = "Bearer #{@access_token}" if @access_token
      headers
    end

    def faraday_client_options
      {
        headers: default_headers,
        ssl: {
          verify: @ssl,
        },
        url: base_host,
        request: {:timeout => Settings.client.timeout}
      }
    end

    def process(request_method, path, params, headers)
      begin
        response = connection.send(request_method, URI.escape(path), params, headers)
      rescue Faraday::Error::ResourceNotFound => e
        raise NotFound, e.message
      rescue Faraday::Error::TimeoutError => e
        raise TimeOutError, e.message
      rescue Faraday::Error::ConnectionFailed => e
        raise ServerError, e.message
      rescue Faraday::Error::ClientError => e
        raise BadRequest, e.response.body if e.response[:status] == 400

        raise ServerError, e.message
      rescue => e
        raise ServerError, e.message
      end

      Request::Response.new(response)
    end

  end
end
