class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      personalizations_path
    else
      super
    end
  end
end
