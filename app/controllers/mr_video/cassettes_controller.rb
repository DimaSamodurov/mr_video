module MrVideo
  class CassettesController < MrVideoController

    include ActionView::Helpers::NumberHelper

    def index
      @cassettes = Cassette.all
    end

    def show
      @cassette = Cassette.find(params[:id])

      @row_data = @cassette.episodes.map do |episode|
        {
          id: episode.id,
          url: episode.url,
          file: episode.file,
          method: episode.request_method,
          host: episode.uri.host,
          path: episode.uri.path,
          query: episode.uri.query,
          content_size: episode.content.size,
          content_pretty_size: number_to_human_size(episode.content.size),
          status: episode.response.dig('status', 'code'),
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
