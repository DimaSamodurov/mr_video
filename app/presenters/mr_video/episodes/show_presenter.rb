module MrVideo
  module Episodes
    class ShowPresenter

      attr_reader :id, :cassette_id, :fix_relative_links

      extend Forwardable
      # Delegate Episode.instance_methods(false) to episode, except :cassette, :content, :id, :update, :destroy
      def_delegators :episode, :content_type, :headers,
                     :http_interaction, :recorded_at, :request, :request_method,
                     :response, :uri, :url, :website_url

      def initialize(cassette_id:, id:, fix_relative_links: false)
        @cassette_id = cassette_id
        @id = id
        @fix_relative_links = fix_relative_links
      end

      def content
        if fix_relative_links
          content_with_relative_links_fixed
        else
          episode.content
        end
      end

      def status
        episode.response.dig('status', 'code')
      end

      def content_with_relative_links_fixed
        fixed_content = episode.content
        [
          /href=["']([^'" >]+)["']/,
          /src=["']([^'" >]+)["']/,
          /@import url\(([^'" >]+)\)/
        ].each do |pattern|
          fixed_content.gsub!(pattern) do |match|
            url = $1
            match.gsub(url, URI.join(website_url, url).to_s)
          end
        end
        fixed_content
      end

      def episode
        @episode ||= cassette.find_episode_by_id(id)
      end

      def cassette
        @cassette ||= Cassette.find(cassette_id)
      end
    end
  end
end
