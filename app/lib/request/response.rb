module Request
  class Response
    def initialize(faraday_response)
      @raw_body        = faraday_response.body
      @raw_headers     = faraday_response.headers
      @raw_status      = faraday_response.status
      @raw_request_url = faraday_response.env.try(:url).try(:to_s)
    end

    def body
      @raw_body
    end

    def headers
      @headers ||= @raw_headers.inject({}) do |result, (key, value)|
        result.merge(key.split("-").map(&:capitalize).join("-") => value)
      end
    end

    def status
      @raw_status
    end

    def request_url
      @raw_request_url
    end
  end
end
