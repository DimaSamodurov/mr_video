module MrVideo
  class EpisodesController < MrVideoController

    def show
      send_data episode_show_presenter.content,
                type: episode_show_presenter.content_type, disposition: 'inline'
    end

    def edit
      @episode_presenter = episode_show_presenter
    end

    def update
      cassette = Cassette.find(params[:cassette_id])
      @episode = cassette.find_episode_by_id(params[:id])
      @episode.update(body: params[:content])
      flash[:success] = "Episode is Updated!"
      redirect_to action: 'edit'
    end

    def destroy
      cassette = Cassette.find(params[:cassette_id])
      @episode = cassette.find_episode_by_id(params[:id])
      @episode.destroy
      render json: {}
    end

    private

    def episode_show_presenter
      episode_params = params.permit(:cassette_id, :id, :fix_relative_links).to_h.symbolize_keys
      @episode_show_presenter ||= Episodes::ShowPresenter.new(**episode_params)
    end
  end
end
