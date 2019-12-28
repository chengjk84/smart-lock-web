class ApplicationController < ActionController::Base
  private
    def current_user
      @current_user ||= session[:username] if session[:access_token]
    end
    
    helper_method :current_user
      
    def authorize
      redirect_to new_session_url, alert: "Not authorized" if current_user.nil?
    end
end
