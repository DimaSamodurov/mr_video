Rails.application.routes.draw do

  root to: 'application#index'

  if Rails.env.development?
    mount MrVideo::Engine => '/mr_video'
  end

end
