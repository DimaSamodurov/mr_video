module MrVideo
  class CassettesController < MrVideoController

    def index
      @cassettes = Cassette.all
    end

    def show
      @cassette = Cassette.find(params[:id])

      @row_data = @cassette.episodes.map do |episode|
        uri = URI(episode.url) rescue OpenStruct.new
        {
          id: episode.id,
          url: episode.url,
          host: uri.host,
          path: uri.path,
          query: uri.query,
          status: episode.response.dig('status', 'code'),
          content_link: helpers.link_to(uri.path, cassette_episode_path(@cassette, episode, fix_relative_links: false),
                                        html_options = { target: '_blank' }),
          edit_episode_path: edit_cassette_episode_path(@cassette, episode),
          episode_path: cassette_episode_path(@cassette, episode)
        }
      end

      render 'mr_video/cassettes/show_ag'
    end

    def destroy
      @cassette = Cassette.find(params[:id])
      @cassette.destroy    
    end

  end
end
