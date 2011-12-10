class ApplicationController < ActionController::Base
  protect_from_forgery

 def render_json json = "operation success",count = 5
    json = { :content => json, :count => count} unless json.is_a? Hash
    json[:success] = true if json[:success].nil?
    render :json => json 
  end

end
