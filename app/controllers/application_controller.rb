class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  protected
    def not_found
      render 'errors/404', status: :not_found
    end
end
