class ApplicationController < ActionController::Base
  protect_from_forgery

  def render_json json = "success"
    render :json => json
  end
end
