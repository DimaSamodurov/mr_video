class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
    render plain: 'Hello from Dummy app!'
  end
end
