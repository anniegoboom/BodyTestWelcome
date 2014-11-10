class Users::ConfirmationsController < Devise::ConfirmationsController

  def show
    if params[:confirmation_token].present?
      @original_token = params[:confirmation_token]
    elsif params[resource_name].try(:[], :confirmation_token).present?
      @original_token = params[resource_name][:confirmation_token]
    end

    self.resource = resource_class.find_by_confirmation_token Devise.token_generator.
      digest(self, :confirmation_token, @original_token)

    super if resource.nil? or resource.confirmed?
  end

  def confirm
    #password too short
    #passwords dont match
    @original_token = params[resource_name].try(:[], :confirmation_token)
    digested_token = Devise.token_generator.digest(self, :confirmation_token, @original_token)

    self.resource = resource_class.find_by_confirmation_token digested_token

    if self.resource.nil?
      flash_error_on_current_page "Can't find original User. Please check your confirmation email again."
    else
      resource.assign_attributes(permitted_params)

      if resource.valid? && resource.password_match?
      self.resource.confirm!
      set_flash_message :notice, :confirmed
      sign_in_and_redirect resource_name, resource
      else
        flash_error_on_current_page resource.errors.full_messages.map { |msg| msg }.join("\n")
      end
    end
  end

  private

  def permitted_params
    params.require(resource_name).permit(:confirmation_token, :password, :password_confirmation)
  end

  def flash_error_on_current_page(msg)
    flash[:error] = "Sorry, \n #{msg}"
    render :show
  end
end
