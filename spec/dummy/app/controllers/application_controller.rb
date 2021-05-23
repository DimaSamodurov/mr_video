class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
    render html: <<~HTML.html_safe
      <p>Hello from Dummy app!</p> 
      <p>You might want to visit #{helpers.link_to('/mr_video', '/mr_video')} path to see engine in action.</p>
    HTML
  end
end
