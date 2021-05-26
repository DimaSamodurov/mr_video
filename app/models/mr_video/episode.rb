module MrVideo
  class Episode

    attr_reader :cassette, :http_interaction

    def initialize(cassette, http_interaction)
      @cassette = cassette
      @http_interaction = http_interaction
    end

    def id
      @id ||= IdService.encode(url)
    end

    def inspect
      to_s
    end

    def to_param
      id.to_s
    end

    def request
      http_interaction['request']
    end

    def response
      http_interaction['response']
    end

    def headers
      @headers ||= response['headers'].transform_keys(&:downcase)
    end

    def url
      request['uri']
    end

    def website_url
      @website_url ||= "#{uri.scheme}://#{uri.host}"
    end

    def uri
      @uri ||= URI(url)
    end

    def file
      "#{uri.path}?#{uri.query}"
    end

    def request_method
      request['method']
    end

    def content
      response['body']['string']
    end

    def content_type
      headers['content-type'][0]
    end

    def recorded_at
      Time.zone.parse(http_interaction['recorded_at'].to_s).to_datetime
    end

    # actions

    def destroy
      cassette.destroy_episode(self)
    end

    def update(body:)
      response['body']['string'] = body
      cassette.save!
    end
  end
end
