class Users::RegistrationsController < Devise::RegistrationsController
  protected
    def after_sign_up_path_for(resource)
      if resource.is_a?(User)
        personalizations_path
      else
        super
      end
    end

    # def after_update_path_for(resource)
    #   signed_in_root_path(resource)
    # end
end
