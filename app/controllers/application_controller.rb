class ApplicationController < ActionController::API
  include AuthorizeRequest
  
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  private

  def record_not_found(exception)
    render json: { 
      errors: exception.message
    }, status: :not_found
  end

  def record_invalid(exception)
    render json: {
      # errors: exception.message
      errors: exception.record.errors.messages       # Returns structured errors: { "errors": { "name": ["can't be blank"], "email": ["is invalid"] } } 
    }, status: :unprocessable_entity
  end

  def authorize_admin
    unless @current_user.admin? || @current_user.super_admin?
      render json: {
        message: "Access Denied!!!"
      }, status: :forbidden
    end
  end

  def authorize_super_admin
    unless @current_user.super_admin?
      render json: {
        message: "Only Super Admin Allowed!!!"
      }, status: :forbidden
    end
  end
end
