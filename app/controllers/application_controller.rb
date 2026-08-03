class ApplicationController < ActionController::API
  include AuthorizeRequest
  
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  rescue_from JWT::DecodeError, with: :decode_error

  rescue_from JWT::ExpiredSignature, with: :expired_signature

  private

  def record_not_found(exception) 
    render json: { 
      errors: exception.message
      # errors: exception.class
      # errors: exception.backtrace
      # message: "Could not find user"
    }, status: :not_found # Rails converts into 404 internally
  end

  def record_invalid(exception)   # Handles create! and save! failures.
    render json: {
      errors: exception.message
    }, status: :unprocessable_entity
  end

  def authorize_admin
    unless @current_user.admin? || @current_user.super_admin?   # admin? - AcrtiveRecord Enum
      render json: {
        message: "Only Admin Or Super Admin Is Allowed To Do..."
      }, status: :forbidden
    end
  end

  def authorize_super_admin
    unless @current_user.super_admin?
      render json: {
        message: "Only Super Admin Is Allowed To Do..."
      }, status: :forbidden
    end
  end

  def decode_error
    render json: { 
      message: "Token invalid..."
    }, status: :unauthorized
  end

  def expired_signature
    render json: { 
      message: "Token Expired..."
    }, status: :unauthorized
  end
end


# Expired token - eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxNSwiZXhwIjoxNzg0OTU0MzIwfQ.hK5RR65lB01js5jVYJBNF4WthfaztHq-fUnmkhKGP8Q

