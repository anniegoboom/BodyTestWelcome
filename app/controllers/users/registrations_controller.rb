class Users::RegistrationsController < Devise::RegistrationsController

  def create
    build_resource(sign_up_params)

    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        #deactivated users? O__o
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
      display_error_on_homepage
    end
  end

  # def update
  #   self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
  #   prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

  #   resource_updated = update_resource(resource, account_update_params)
  #   binding.pry
  #   yield resource if block_given?
  #   if resource_updated
  #     if is_flashing_format?
  #       flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
  #         :update_needs_confirmation : :updated
  #       set_flash_message :notice, flash_key
  #     end
  #     sign_in resource_name, resource, bypass: true
  #     respond_with resource, location: after_update_path_for(resource)
  #   else
  #     clean_up_passwords resource
  #     display_error_on_password_creation_page
  #   end
  # end


  protected

  def after_sign_up_path_for(resource)
    if resource.is_a?(User)
      new_personalizations_path
    else
      super
    end
  end

  private

  def display_error_on_homepage
    errors_array = resource.errors.full_messages.map { |msg| msg }.join("\n")
    flash[:error] = "Sorry, \n #{errors_array}"
    redirect_to root_url
  end
end
